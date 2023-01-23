import 'package:crm/features/admin/staff/core/data/repository/staff_repository.dart';
import 'package:crm/features/admin/staff/core/domain/usecase/staff_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_staff_state.dart';

class UploadStaffCubit extends Cubit<UploadStaffState> {
  StaffRepository _repository;

  UploadStaffCubit({
    required StaffRepository repository,
  })  : _repository = repository,
        super(UploadStaffState());

  Future<void> getStaffEmployeeData(int? id) async {
    try {
      if (id != null) {
        emit(state.copyWith(isLoading: true));
        final data = await _repository.getEmployeeData(id: id);
        emit(state.copyWith(
          id: id,
          name: data.name,
          surname: data.surname,
          patronymic: data.patronymic,
          birthday: data.birthday,
          login: data.login,
          password: data.password,
          workplace: data.workplace,
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

  void onLoginChange(String login) {
    emit(state.copyWith(login: login));
  }

  void onPasswordChange(String pass) {
    emit(state.copyWith(password: pass));
  }

  void onWorkplaceChange(int place) {
    emit(state.copyWith(workplace: place));
  }

  Future<void> onUpload() async {
    try {
      emit(state.copyWith(isUploading: true));
      await _repository.uploadStaffEmployee(UploadStaffEmployeeParams(
        id: state.id,
        name: state.name,
        surname: state.surname,
        patronymic: state.patronymic,
        birthday: state.birthday!,
        login: state.login,
        password: state.password,
        workplace: state.workplace!,
      ));
      emit(state.copyWith(successfullyUploaded: true));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
      addError(e);
    }
  }
}
