import 'package:crm/features/admin/staff/staff_screen/data/repository/staff_repository.dart';
import 'package:crm/features/admin/staff/staff_screen/domain/entity/staff_model.dart';
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
      emit(state.copyWith(isLoading: true, isFailure: false));
      final data = await _repository.getStaffData();
      emit(state.copyWith(
        isLoading: false,
        staffData: data,
        filteredStaffData: data,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
