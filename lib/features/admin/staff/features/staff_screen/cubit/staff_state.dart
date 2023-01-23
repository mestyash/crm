part of 'staff_cubit.dart';

class StaffState extends Equatable {
  const StaffState({
    this.isLoading = false,
    this.isDeleting = false,
    this.successfullyDeleted = false,
    this.isFailure = false,
    // ----
    this.text = '',
    // ----
    this.staffData = null,
    this.filteredStaffData = null,
  });

  final bool isLoading;
  final bool isDeleting;
  final bool successfullyDeleted;
  final bool isFailure;
  // ----
  final String text;
  // ----
  final List<StaffEmployeeModel>? staffData;
  final List<StaffEmployeeModel>? filteredStaffData;

  bool get isScreenLoading => isLoading && staffData == null;

  StaffState copyWith({
    bool? isLoading,
    bool? isDeleting,
    bool? successfullyDeleted,
    bool? isFailure,
    // ----
    String? text,
    // ----
    List<StaffEmployeeModel>? staffData,
    List<StaffEmployeeModel>? filteredStaffData,
  }) =>
      StaffState(
        isLoading: isLoading ?? this.isLoading,
        isDeleting: isDeleting ?? this.isDeleting,
        successfullyDeleted: successfullyDeleted ?? this.successfullyDeleted,
        isFailure: isFailure ?? false,
        // ----
        text: text ?? this.text,
        // ----
        staffData: staffData ?? this.staffData,
        filteredStaffData: filteredStaffData ?? this.filteredStaffData,
      );

  @override
  List<Object?> get props => [
        isLoading,
        isDeleting,
        successfullyDeleted,
        isFailure,
        // ----
        text,
        // ----
        staffData,
        filteredStaffData,
      ];
}
