part of 'create_payment_cubit.dart';

class CreatePaymentState extends Equatable {
  CreatePaymentState({
    this.isLoading = false,
    this.successfullyCreated = false,
    this.textFailure = false,
    this.isFailure = false,
    // ----
    this.student,
    this.sum = 0,
    this.date,
  });

  final bool isLoading;
  final bool successfullyCreated;
  final bool textFailure;
  final bool isFailure;
  // ----
  final User? student;
  final double sum;
  final DateTime? date;

  CreatePaymentState copyWith({
    bool? isLoading,
    bool? successfullyCreated,
    bool? textFailure,
    bool? isFailure,
    // ----
    User? student,
    double? sum,
    DateTime? date,
  }) {
    return CreatePaymentState(
      isLoading: isLoading ?? this.isLoading,
      successfullyCreated: successfullyCreated ?? this.successfullyCreated,
      textFailure: textFailure ?? false,
      isFailure: isFailure ?? false,
      // ----
      student: student ?? this.student,
      sum: sum ?? this.sum,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        successfullyCreated,
        textFailure,
        isFailure,
        // ----
        student,
        sum,
        date,
      ];
}
