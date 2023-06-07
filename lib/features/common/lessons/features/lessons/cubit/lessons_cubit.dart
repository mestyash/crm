import 'dart:async';

import 'package:crm/core/domain/entity/lesson/lesson_model.dart';
import 'package:crm/features/common/lessons/core/domain/lessons_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  final ILessonsRepository _repository;

  LessonsCubit({required ILessonsRepository repository})
      : _repository = repository,
        super(LessonsState());

  Future<void> loadLessons(int groupId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final lessons = await _repository.loadLessons(groupId: groupId);
      emit(state.copyWith(
        isLoading: false,
        lessons: lessons,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
