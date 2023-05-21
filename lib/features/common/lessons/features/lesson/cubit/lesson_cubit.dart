import 'dart:async';

import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/domain/entity/lesson/lesson_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/common/lessons/core/data/lessons_repository.dart';
import 'package:crm/features/common/lessons/core/domain/lessons_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  final LessonsRepository _repository;

  LessonCubit({required LessonsRepository repository})
      : _repository = repository,
        super(LessonState());

  Future<void> loadInitialData({int? groupId, int? lessonId}) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (groupId != null) {
        final data = await _repository.loadGroup(id: groupId);
        emit(state.copyWith(isLoading: false, group: data));
        return;
      }
      if (lessonId != null) {
        final data = await _repository.loadLesson(id: lessonId);
        emit(state.copyWith(isLoading: false, lesson: data));
        return;
      }
    } catch (e) {
      emit(state.copyWith(isFailure: true));
    }
  }

  void onSelectStudent(int id) {
    final List<int> updatedIds;

    if (state.studentIds.contains(id)) {
      updatedIds = [...state.studentIds].where((e) => e != id).toList();
    } else {
      updatedIds = [...state.studentIds, id];
    }

    emit(state.copyWith(studentIds: updatedIds));
  }

  void onCommentChange(String text) {
    emit(state.copyWith(comment: text));
  }

  Future<void> onDelete() async {
    try {
      emit(state.copyWith(isUploading: true));
      await _repository.deleteLesson(id: state.lesson!.id);
      emit(state.copyWith(successfullyDeleted: true));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
    }
  }

  Future<void> onUpload() async {
    try {
      emit(state.copyWith(isUploading: true));
      final group = state.group!;
      await _repository.createLesson(
        CreateLessonParams(
          teacherId: group.teacher!.id,
          groupId: group.id,
          price: group.price,
          salary: group.salary,
          date: DateTime.now(),
          visitingStudentIds: state.studentIds,
          comment: state.comment,
        ),
      );
      emit(state.copyWith(successfullyCreated: true));
    } catch (e) {
      emit(state.copyWith(isUploading: false, isFailure: true));
    }
  }
}
