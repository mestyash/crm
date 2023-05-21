part of 'create_payment_bloc.dart';

class CreatePaymentState extends Equatable {
  CreatePaymentState({
    this.isLoading = false,
    this.isSearching = false,
    this.successfullyCreated = false,
    this.textFailure = false,
    this.isFailure = false,
    // ----
    this.students = const [],
    this.student,
    this.sum = 0,
    this.date,
  });

  final bool isLoading;
  final bool isSearching;
  final bool successfullyCreated;
  final bool textFailure;
  final bool isFailure;
  // ----
  final List<UserModel> students;
  final UserModel? student;
  final double sum;
  final DateTime? date;

  bool get canUpload => ![
        !isFailure,
        !textFailure,
        student != null,
        sum > 0,
        date != null,
        !textFailure,
      ].contains(false);

  CreatePaymentState copyWith({
    bool? isLoading,
    bool? isSearching,
    bool? successfullyCreated,
    bool? textFailure,
    bool? isFailure,
    // ----
    List<UserModel>? students,
    UserModel? student,
    double? sum,
    DateTime? date,
  }) {
    return CreatePaymentState(
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      successfullyCreated: successfullyCreated ?? this.successfullyCreated,
      textFailure: textFailure ?? this.textFailure,
      isFailure: isFailure ?? false,
      // ----
      students: students ?? this.students,
      student: student ?? this.student,
      sum: sum ?? this.sum,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSearching,
        successfullyCreated,
        textFailure,
        isFailure,
        // ----
        students,
        student,
        sum,
        date,
      ];
}
