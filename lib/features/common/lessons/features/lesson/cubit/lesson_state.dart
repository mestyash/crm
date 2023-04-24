part of 'lesson_cubit.dart';

class LessonState extends Equatable {
  LessonState({
    this.isLoading = false,
    this.isUploading = false,
    this.successfullyCreated = false,
    this.isFailure = false,
    // ----
    this.id,
    this.lesson,
    this.group,
    // ----
    this.date,
    this.studentIds = const [],
    this.comment = '',
  });

  final bool isLoading;
  final bool isUploading;
  final bool successfullyCreated;
  final bool isFailure;
  // ----
  final int? id;
  final LessonModel? lesson;
  final GroupModel? group;
  // ----
  final DateTime? date;
  final List<int> studentIds;
  final String comment;

  LessonState copyWith({
    bool? isLoading,
    bool? isUploading,
    bool? successfullyCreated,
    bool? isFailure,
    // ----
    int? id,
    LessonModel? lesson,
    GroupModel? group,
    // ----
    DateTime? date,
    List<int>? studentIds,
    String? comment,
  }) {
    return LessonState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      successfullyCreated: successfullyCreated ?? this.successfullyCreated,
      isFailure: isFailure ?? false,
      // ----
      id: id ?? this.id,
      lesson: lesson ?? this.lesson,
      group: group ?? this.group,
      // ----
      date: date ?? this.date,
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
      isFailure,
      // ----
      id,
      lesson,
      group,
      // ----
      date,
      studentIds,
      comment,
    ];
  }
}
