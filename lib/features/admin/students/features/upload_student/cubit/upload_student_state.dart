part of 'upload_student_cubit.dart';

class UploadStudentState extends Equatable {
  const UploadStudentState({
    this.isLoading = false,
    this.isUploading = false,
    this.successfullyCreated = false,
    this.successfullyEdited = false,
    this.isFailure = false,
    // ----
    this.id,
    // ----
    this.name = '',
    this.surname = '',
    this.patronymic = '',
    this.birthday,
  });

  final bool isLoading;
  final bool isUploading;
  final bool successfullyCreated;
  final bool successfullyEdited;
  final bool isFailure;
  // ----
  final int? id;
  // ----
  final String name;
  final String surname;
  final String patronymic;
  final DateTime? birthday;

  bool get canSend => ![
        name.trim().isNotEmpty,
        surname.trim().isNotEmpty,
        patronymic.trim().isNotEmpty,
        birthday != null,
      ].contains(false);

  UploadStudentState copyWith({
    bool? isLoading,
    bool? isUploading,
    bool? successfullyCreated,
    bool? successfullyEdited,
    bool? isFailure,
    // ----
    int? id,
    // ----
    String? name,
    String? surname,
    String? patronymic,
    DateTime? birthday,
  }) =>
      UploadStudentState(
        isLoading: isLoading ?? this.isLoading,
        isUploading: isUploading ?? this.isUploading,
        successfullyCreated: successfullyCreated ?? this.successfullyCreated,
        successfullyEdited: successfullyEdited ?? this.successfullyEdited,
        isFailure: isFailure ?? false,
        // ----
        id: id ?? this.id,
        // ----
        name: name ?? this.name,
        surname: surname ?? this.surname,
        patronymic: patronymic ?? this.patronymic,
        birthday: birthday ?? this.birthday,
      );

  @override
  List<Object?> get props => [
        isLoading,
        isUploading,
        successfullyCreated,
        successfullyEdited,
        isFailure,
        // ----
        id,
        // ----
        name,
        surname,
        patronymic,
        birthday,
      ];
}
