part of 'lesson_cubit.dart';

class LessonState extends Equatable {
  LessonState({
    this.isLoading = false,
    this.isUploading = false,
    this.successfullyCreated = false,
    this.successfullyDeleted = false,
    this.isFailure = false,
    // ----
    this.lesson,
    this.group,
    // ----
    this.studentIds = const [],
    this.comment = '',
  });

  final bool isLoading;
  final bool isUploading;
  final bool successfullyCreated;
  final bool successfullyDeleted;
  final bool isFailure;
  // ----
  final LessonModel? lesson;
  final GroupModel? group;
  // ----
  final List<int> studentIds;
  final String comment;

  bool get canCreate => ![
        studentIds.isNotEmpty,
        group?.teacher != null,
      ].contains(false);

  bool get isCreating => group != null;
  bool get canDelete => ![
        !isLoading,
        !isUploading,
        lesson == null
            ? false
            : CustomDateUtils.dateToString(DateTime.now()) ==
                CustomDateUtils.dateToString(lesson!.date)
      ].contains(false);

  LessonState copyWith({
    bool? isLoading,
    bool? isUploading,
    bool? successfullyCreated,
    bool? successfullyDeleted,
    bool? isFailure,
    // ----
    int? id,
    LessonModel? lesson,
    GroupModel? group,
    // ----
    List<int>? studentIds,
    String? comment,
  }) {
    return LessonState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      successfullyCreated: successfullyCreated ?? this.successfullyCreated,
      successfullyDeleted: successfullyDeleted ?? this.successfullyDeleted,
      isFailure: isFailure ?? false,
      // ----
      lesson: lesson ?? this.lesson,
      group: group ?? this.group,
      // ----
      studentIds: studentIds ?? this.studentIds,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isUploading,
      successfullyCreated,
      successfullyDeleted,
      isFailure,
      // ----
      lesson,
      group,
      // ----
      studentIds,
      comment,
    ];
  }
}
