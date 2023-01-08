part of 'staff_cubit.dart';

class StaffState extends Equatable {
  const StaffState({
    this.isLoading = false,
    this.isFailure = false,
    // ----
    this.staffData = null,
  });

  final bool isLoading;
  final bool isFailure;
  // ----
  final List<StaffModel>? staffData;

  bool get isScreenLoading => isLoading && staffData == null;

  StaffState copyWith({
    bool? isLoading,
    bool? isFailure,
    // ----
    List<StaffModel>? staffData,
  }) =>
      StaffState(
        isLoading: isLoading ?? this.isLoading,
        isFailure: isFailure ?? this.isFailure,
        // ----
        staffData: staffData ?? this.staffData,
      );

  @override
  List<Object?> get props => [
        isLoading,
        isFailure,
        // ----
        staffData,
      ];
}
