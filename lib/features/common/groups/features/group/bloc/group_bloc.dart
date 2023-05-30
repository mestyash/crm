import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/common/groups/core/domain/groups_usecase.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final IGroupsRepository _repository;

  GroupBloc({required IGroupsRepository repository})
      : _repository = repository,
        super(GroupState()) {
    on<GroupEventLoad>(_onGroupLoad);
    on<GroupEventName>(_onNameChange);
    on<GroupEventLanguage>(_onLanguageChange);
    on<GroupEventSearchTeacher>(_onSearchTeacher, transformer: restartable());
    on<GroupEventSelectTeacher>(_onSelectTeacher);
    on<GroupEventSearchStudent>(_onSearchStudent, transformer: restartable());
    on<GroupEventSelectStudent>(_onSelectStudent);
    on<GroupEventRemoveStudent>(_onRemoveStudent);
    on<GroupEventPrice>(_onPriceChange);
    on<GroupEventSalary>(_onSalaryChange);
    on<GroupEventActive>(_onActiveChange);
    on<GroupEventUpload>(_onUpload);
  }

  Future<void> _onGroupLoad(
    GroupEventLoad event,
    Emitter<GroupState> emit,
  ) async {
    if (event.id == null) return;
    try {
      emit(state.copyWith(isLoading: true));
      final data = await _repository.getGroup(id: event.id!);
      emit(state.copyWith(
        isLoading: false,
        id: event.id,
        name: data.name,
        language: data.language,
        teacher: data.teacher,
        price: data.price,
        salary: data.salary,
        students: data.students,
        isActive: data.isActive,
      ));
    } catch (e) {
      emit(state.copyWith(isFailure: true));
    }
  }

  void _onNameChange(
    GroupEventName event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onLanguageChange(
    GroupEventLanguage event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(language: event.language));
  }

  Future<void> _onSearchTeacher(
    GroupEventSearchTeacher event,
    Emitter<GroupState> emit,
  ) async {
    if (event.surname.length > 1) {
      try {
        emit(state.copyWith(isSearching: true));
        final data = await _repository.searchTeacher(surname: event.surname);
        final availableTeachers =
            data.where((e) => e.id != state.teacher?.id).toList();
        emit(state.copyWith(
          isSearching: false,
          availableTeachers: availableTeachers,
        ));
      } catch (e) {
        emit(state.copyWith(isSearching: false, isFailure: true));
      }
    } else {
      emit(state.copyWith(isSearching: false, availableTeachers: []));
    }
  }

  void _onSelectTeacher(
    GroupEventSelectTeacher event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(teacher: event.teacher, availableTeachers: []));
  }

  Future<void> _onSearchStudent(
    GroupEventSearchStudent event,
    Emitter<GroupState> emit,
  ) async {
    if (event.surname.length > 1) {
      try {
        emit(state.copyWith(isSearching: true));
        final data = await _repository.searchStudent(surname: event.surname);

        final selectedStudentIds = state.students.map((e) => e.id);
        final availableStudents = data
            .where(
              (e) => !selectedStudentIds.contains(e.id),
            )
            .toList();

        emit(state.copyWith(
          isSearching: false,
          availableStudents: availableStudents,
        ));
      } catch (e) {
        emit(state.copyWith(isSearching: false, isFailure: true));
      }
    } else {
      emit(state.copyWith(isSearching: false, availableStudents: []));
    }
  }

  void _onSelectStudent(
    GroupEventSelectStudent event,
    Emitter<GroupState> emit,
  ) {
    final students = [...state.students, event.student]..sort(
        (a, b) => a.fullName.compareTo(b.fullName),
      );

    emit(state.copyWith(students: students, availableStudents: []));
  }

  void _onRemoveStudent(
    GroupEventRemoveStudent event,
    Emitter<GroupState> emit,
  ) {
    final students = state.students.where((e) => e.id != event.id).toList();
    emit(state.copyWith(students: students));
  }

  void _onPriceChange(
    GroupEventPrice event,
    Emitter<GroupState> emit,
  ) {
    try {
      final stringPrice = event.price;
      if (stringPrice.isNotEmpty) {
        final price = double.parse(event.price);
        emit(state.copyWith(price: price, priceTextFailure: false));
      } else {
        emit(state.copyWith(price: 0, priceTextFailure: false));
      }
    } catch (e) {
      emit(state.copyWith(priceTextFailure: true));
    }
  }

  void _onSalaryChange(
    GroupEventSalary event,
    Emitter<GroupState> emit,
  ) {
    try {
      final stringSalary = event.salary;
      if (stringSalary.isNotEmpty) {
        final salary = double.parse(event.salary);
        emit(state.copyWith(salary: salary, slaryTextFailure: false));
      } else {
        emit(state.copyWith(salary: 0, slaryTextFailure: false));
      }
    } catch (e) {
      emit(state.copyWith(slaryTextFailure: true));
    }
  }

  void _onActiveChange(
    GroupEventActive event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(isActive: !state.isActive));
  }

  Future<void> _onUpload(
    GroupEventUpload event,
    Emitter<GroupState> emit,
  ) async {
    try {
      emit(state.copyWith(isUploading: true));
      await _repository.uploadGroup(UploadGroupParams(
        id: state.id,
        name: state.name,
        language: state.language!,
        teacherId: state.teacher!.id,
        price: state.price,
        salary: state.salary,
        studentIds: state.students.map((e) => e.id).toList(),
        isActive: state.isActive,
      ));
      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
    }
  }
}
