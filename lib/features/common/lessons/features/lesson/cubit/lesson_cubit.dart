import 'dart:async';

import 'package:crm/core/domain/entity/group/group_model.dart';
import 'package:crm/core/domain/entity/lesson/lesson_model.dart';
import 'package:crm/features/common/lessons/core/data/lessons_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  final LessonsRepository _repository;

  LessonCubit({required LessonsRepository repository})
      : _repository = repository,
        super(LessonState());

  Future<void> loadLesson(int groupId, {int? lessonId}) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (lessonId != null) {
        // await Future.wait([
// _repository.loadLesson(id: id)
        // _repository.loadGroup(id: groupId),
        // ]);
      } else {}

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isFailure: true));
    }
  }
}
