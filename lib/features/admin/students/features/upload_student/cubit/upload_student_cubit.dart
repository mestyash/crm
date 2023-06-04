import 'package:crm/features/admin/students/core/domain/students_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_student_state.dart';

class UploadStudentCubit extends Cubit<UploadStudentState> {
  IStudentsRepository _repository;

  UploadStudentCubit({
    required IStudentsRepository repository,
  })  : _repository = repository,
        super(UploadStudentState());

  Future<void> getStudentData(int? id) async {
    try {
      if (id != null) {
        emit(state.copyWith(isLoading: true));
        final data = await _repository.getStudent(id: id);
        emit(state.copyWith(
          id: id,
          name: data.name,
          surname: data.surname,
          patronymic: data.patronymic,
          birthday: data.birthday,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isFailure: true));
      addError(e);
    }
  }

  void onNameChange(String name) {
    emit(state.copyWith(name: name));
  }

  void onSurnameChange(String surname) {
    emit(state.copyWith(surname: surname));
  }

  void onPatronymicChange(String patronymic) {
    emit(state.copyWith(patronymic: patronymic));
  }

  void onBirthdayChange(DateTime date) {
    emit(state.copyWith(birthday: date));
  }

  Future<void> onUpload() async {
    try {
      emit(state.copyWith(isUploading: true));
      await _repository.uploadStudent(UploadStudentParams(
        id: state.id,
        name: state.name,
        surname: state.surname,
        patronymic: state.patronymic,
        birthday: state.birthday!,
      ));
      if (state.id == null) {
        emit(state.copyWith(successfullyCreated: true));
      } else {
        emit(state.copyWith(successfullyEdited: true));
      }
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
      addError(e);
    }
  }
}
