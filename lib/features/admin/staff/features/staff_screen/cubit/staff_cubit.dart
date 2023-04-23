import 'package:crm/features/admin/staff/core/data/staff_repository.dart';
import 'package:crm/core/domain/entity/staff_employee/staff_employee_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  StaffRepository _repository;

  StaffCubit({
    required StaffRepository repository,
  })  : _repository = repository,
        super(StaffState());

  Future<void> loadStaffData() async {
    try {
      emit(state.copyWith(isLoading: true));
      final data = await _repository.getStaffData();
      final filteredStaffData = _filterByText(data, state.text);
      emit(state.copyWith(
        isLoading: false,
        staffData: data,
        filteredStaffData: filteredStaffData,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }

  void onTextChange(String text) {
    final filteredStaffData = _filterByText(state.staffData!, text);
    emit(state.copyWith(text: text, filteredStaffData: filteredStaffData));
  }

  Future<void> deleteStaffEmployee(int id) async {
    try {
      emit(state.copyWith(isDeleting: true));
      await _repository.deleteStaffEmployee(id: id);
      final staffData = await _repository.getStaffData();
      final filteredStaffData = _filterByText(staffData, state.text);
      emit(state.copyWith(
        isDeleting: false,
        successfullyDeleted: true,
        staffData: staffData,
        filteredStaffData: filteredStaffData,
      ));
    } catch (e) {
      emit(state.copyWith(isDeleting: false, isFailure: true));
      addError(e);
    }
  }

  // --- utils ---
  List<StaffEmployeeModel> _filterByText(
    List<StaffEmployeeModel> staff,
    String text,
  ) {
    return staff.where((e) => e.userData.fullName.contains(text)).toList();
  }
}
