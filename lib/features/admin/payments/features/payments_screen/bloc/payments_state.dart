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
    this.studentInList = const [],
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
  final List<UserModel> studentInList;
  final List<UserModel> students;
  final List<PaymentModel> payments;

  bool get canSearch {
    final hasDates = startDate != null && endDate != null;
    if (mode == PaymentsStateMode.all) {
      return hasDates;
    } else {
      return hasDates && studentInList.isNotEmpty;
    }
  }

  UserModel? get student {
    if (studentInList.isNotEmpty) {
      return studentInList[0];
    } else {
      return null;
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
    List<UserModel>? studentInList,
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
      studentInList: studentInList ?? this.studentInList,
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
      studentInList,
      students,
      payments,
    ];
  }
}

enum PaymentsStateMode {
  all,
  student,
}
