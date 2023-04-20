import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/common/groups/core/data/groups_repository.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupsRepository _groupsRepository;

  GroupBloc({required GroupsRepository groupsRepository})
      : _groupsRepository = groupsRepository,
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
    if (event.id != null) return;
    try {
      emit(state.copyWith(isLoading: true));
      final data = await _groupsRepository.getGroup(id: event.id!);
      emit(state.copyWith(
        isLoading: false,
        id: event.id,
        name: data.name,
        teacher: data.teacher,
        price: data.price,
        salary: data.salary,
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
    try {
      emit(state.copyWith(isSearching: true));

      emit(state.copyWith(isSearching: false));
    } catch (e) {
      emit(state.copyWith(isSearching: false, isFailure: true));
    }
  }

  void _onSelectTeacher(
    GroupEventSelectTeacher event,
    Emitter<GroupState> emit,
  ) {
    emit(state.copyWith(teacher: event.teacher));
  }

  Future<void> _onSearchStudent(
    GroupEventSearchStudent event,
    Emitter<GroupState> emit,
  ) async {
    try {
      emit(state.copyWith(isSearching: true));

      emit(state.copyWith(isSearching: false));
    } catch (e) {
      emit(state.copyWith(isSearching: false, isFailure: true));
    }
  }

  void _onSelectStudent(
    GroupEventSelectStudent event,
    Emitter<GroupState> emit,
  ) {
    final students = [...state.students, event.student]..sort(
        (a, b) => a.fullName.compareTo(b.fullName),
      );

    final availableStudents = [...state.availableStudents]
        .where((e) => e.id != event.student.id)
        .toList();

    emit(state.copyWith(
      students: students,
      availableStudents: availableStudents,
    ));
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
      final price = double.parse(event.price);
      emit(state.copyWith(price: price, textFailure: false));
    } catch (e) {
      emit(state.copyWith(textFailure: true));
    }
  }

  void _onSalaryChange(
    GroupEventSalary event,
    Emitter<GroupState> emit,
  ) {
    try {
      final salary = double.parse(event.salary);
      emit(state.copyWith(price: salary, textFailure: false));
    } catch (e) {
      emit(state.copyWith(textFailure: true));
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

      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isUploading: true, isFailure: false));
    }
  }
}
