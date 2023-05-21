part of 'group_bloc.dart';

class GroupState extends Equatable {
  GroupState({
    this.isLoading = false,
    this.isUploading = false,
    this.isSearching = false,
    this.successfullyCreated = false,
    this.priceTextFailure = false,
    this.slaryTextFailure = false,
    this.isFailure = false,
    // ----
    this.id,
    this.name = '',
    this.language,
    this.teacher,
    this.availableTeachers = const [],
    this.price = 0,
    this.salary = 0,
    this.isActive = true,
    this.students = const [],
    this.availableStudents = const [],
  });

  final bool isLoading;
  final bool isSearching;
  final bool isUploading;
  final bool successfullyCreated;
  final bool priceTextFailure;
  final bool slaryTextFailure;
  final bool isFailure;
  // ----
  final int? id;
  final String name;
  final int? language;
  final UserModel? teacher;
  final List<UserModel> availableTeachers;
  final num price;
  final num salary;
  final bool isActive;
  final List<UserModel> students;
  final List<UserModel> availableStudents;

  bool get canSend => ![
        name.trim().isNotEmpty,
        language != null,
        teacher != null,
        price > 0,
        salary > 0,
        students.isNotEmpty,
        !priceTextFailure,
        !slaryTextFailure,
      ].contains(false);

  GroupState copyWith({
    bool? isLoading,
    bool? isUploading,
    bool? isSearching,
    bool? successfullyCreated,
    bool? priceTextFailure,
    bool? slaryTextFailure,
    bool? isFailure,
    // ----
    int? id,
    String? name,
    int? language,
    UserModel? teacher,
    List<UserModel>? availableTeachers,
    num? price,
    num? salary,
    bool? isActive,
    List<UserModel>? students,
    List<UserModel>? availableStudents,
  }) {
    return GroupState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      isSearching: isSearching ?? this.isSearching,
      successfullyCreated: successfullyCreated ?? this.successfullyCreated,
      priceTextFailure: priceTextFailure ?? this.priceTextFailure,
      slaryTextFailure: slaryTextFailure ?? this.slaryTextFailure,
      isFailure: isFailure ?? false,
      // ----
      id: id ?? this.id,
      name: name ?? this.name,
      language: language ?? this.language,
      teacher: teacher ?? this.teacher,
      availableTeachers: availableTeachers ?? this.availableTeachers,
      price: price ?? this.price,
      salary: salary ?? this.salary,
      isActive: isActive ?? this.isActive,
      students: students ?? this.students,
      availableStudents: availableStudents ?? this.availableStudents,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isUploading,
      isSearching,
      successfullyCreated,
      priceTextFailure,
      slaryTextFailure,
      isFailure,
      // ----
      id,
      name,
      language,
      teacher,
      availableTeachers,
      price,
      salary,
      isActive,
      students,
      availableStudents,
    ];
  }
}
