part of 'lessons_cubit.dart';

class LessonsState extends Equatable {
  LessonsState({
    this.isLoading = false,
    this.isFailure = false,
    // ----
    this.lessons,
  });

  final bool isLoading;
  final bool isFailure;
  // ----
  final List<LessonModel>? lessons;

  bool get isScreenLoading => isLoading && lessons == null;

  LessonsState copyWith({
    bool? isLoading,
    bool? isFailure,
    // ----
    List<LessonModel>? lessons,
  }) {
    return LessonsState(
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? false,
      // ----
      lessons: lessons ?? this.lessons,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isFailure,
        // ----
        lessons,
      ];
}
