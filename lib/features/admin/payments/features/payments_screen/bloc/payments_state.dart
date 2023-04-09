part of 'payments_bloc.dart';

class PaymentsState extends Equatable {
  PaymentsState({
    this.isLoading = false,
    this.isSearching = false,
    this.isFailure = false,
    // ----
    this.startDate,
    this.endDate,
    this.mode = PaymentsStateMode.all,
    this.student,
    this.students = const [],
    this.payments = const [],
  });

  final bool isLoading;
  final bool isSearching;
  final bool isFailure;
  // ----
  final DateTime? startDate;
  final DateTime? endDate;
  final PaymentsStateMode mode;
  final UserModel? student;
  final List<UserModel> students;
  final List<PaymentModel> payments;

  bool get canSearch {
    final hasDates = startDate != null && endDate != null;
    if (mode == PaymentsStateMode.all) {
      return hasDates;
    } else {
      return hasDates && student != null;
    }
  }

  PaymentsState copyWith({
    bool? isLoading,
    bool? isSearching,
    bool? isFailure,
    // ----
    DateTime? startDate,
    DateTime? endDate,
    PaymentsStateMode? mode,
    Wrapped<UserModel?>? student,
    List<UserModel>? students,
    List<PaymentModel>? payments,
  }) {
    return PaymentsState(
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      isFailure: isFailure ?? false,
      // ----
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      mode: mode ?? this.mode,
      student: student != null ? student.value : this.student,
      students: students ?? this.students,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isSearching,
      isFailure,
      // ----
      startDate,
      endDate,
      mode,
      student,
      students,
      payments,
    ];
  }
}

enum PaymentsStateMode {
  all,
  student,
}
