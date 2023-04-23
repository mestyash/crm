import 'dart:async';

import 'package:crm/core/domain/entity/lesson/lesson_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsState());

  Future<void> loadLessons() async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(Duration(seconds: 3));
      emit(state.copyWith(
        isLoading: false,
        lessons: [],
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true));
    }
  }
}
