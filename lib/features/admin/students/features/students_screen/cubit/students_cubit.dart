import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/features/admin/students/core/domain/students_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  IStudentsRepository _repository;

  StudentsCubit({
    required IStudentsRepository repository,
  })  : _repository = repository,
        super(StudentsState());

  Future<void> loadStudents() async {
    try {
      emit(state.copyWith(isLoading: true));
      final data = await _repository.getStudents();
      final filteredStudents = _filterByText(data, state.text);
      emit(state.copyWith(
        isLoading: false,
        students: data,
        filteredStudents: filteredStudents,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }

  void onTextChange(String text) {
    final filteredStaffData = _filterByText(state.students!, text);
    emit(state.copyWith(text: text, filteredStudents: filteredStaffData));
  }

  Future<void> deleteStudent(int id) async {
    try {
      emit(state.copyWith(isDeleting: true));
      await _repository.deleteStudent(id: id);
      final students = await _repository.getStudents();
      final filteredStudents = _filterByText(students, state.text);
      emit(state.copyWith(
        isDeleting: false,
        successfullyDeleted: true,
        students: students,
        filteredStudents: filteredStudents,
      ));
    } catch (e) {
      emit(state.copyWith(isDeleting: false, isFailure: true));
      addError(e);
    }
  }

  // --- utils ---
  List<UserModel> _filterByText(
    List<UserModel> students,
    String text,
  ) {
    final lowerCaseText = text.toLowerCase();
    return students
        .where((e) => e.fullName.toLowerCase().contains(lowerCaseText))
        .toList();
  }
}
