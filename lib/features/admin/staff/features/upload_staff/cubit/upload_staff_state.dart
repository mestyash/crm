part of 'upload_staff_cubit.dart';

class UploadStaffState extends Equatable {
  const UploadStaffState({
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
    this.login = '',
    this.password = '',
    this.workplace,
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
  final String login;
  final String password;
  final int? workplace;

  bool get canSend => ![
        name.trim().isNotEmpty,
        surname.trim().isNotEmpty,
        patronymic.trim().isNotEmpty,
        birthday != null,
        login.trim().isNotEmpty,
        password.trim().isNotEmpty,
        workplace != null
      ].contains(false);

  UploadStaffState copyWith({
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
    String? login,
    String? password,
    int? workplace,
  }) =>
      UploadStaffState(
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
        login: login ?? this.login,
        password: password ?? this.password,
        workplace: workplace ?? this.workplace,
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
        login,
        password,
        workplace,
      ];
}
