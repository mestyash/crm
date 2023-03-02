part of 'students_cubit.dart';

class StudentsState extends Equatable {
  const StudentsState({
    this.isLoading = false,
    this.isDeleting = false,
    this.successfullyDeleted = false,
    this.isFailure = false,
    // ----
    this.text = '',
    // ----
    this.students = null,
    this.filteredStudents = null,
  });

  final bool isLoading;
  final bool isDeleting;
  final bool successfullyDeleted;
  final bool isFailure;
  // ----
  final String text;
  // ----
  final List<UserModel>? students;
  final List<UserModel>? filteredStudents;

  bool get isScreenLoading => isLoading && students == null;

  StudentsState copyWith({
    bool? isLoading,
    bool? isDeleting,
    bool? successfullyDeleted,
    bool? isFailure,
    // ----
    String? text,
    // ----
    List<UserModel>? students,
    List<UserModel>? filteredStudents,
  }) =>
      StudentsState(
        isLoading: isLoading ?? this.isLoading,
        isDeleting: isDeleting ?? this.isDeleting,
        successfullyDeleted: successfullyDeleted ?? false,
        isFailure: isFailure ?? false,
        // ----
        text: text ?? this.text,
        // ----
        students: students ?? this.students,
        filteredStudents: filteredStudents ?? this.filteredStudents,
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
        students,
        filteredStudents,
      ];
}
