import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/lessons/features/lesson/view/lesson_screen.dart';
import 'package:crm/features/common/lessons/features/lessons/cubit/lessons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsCard extends StatelessWidget {
  final int groupId;
  final int lessonId;
  final String date;

  const LessonsCard({
    super.key,
    required this.groupId,
    required this.lessonId,
    required this.date,
  });

  Future<void> _link(BuildContext context) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.lesson,
      arguments: LessonScreenArguments(lessonId: lessonId),
    );

    if (data != null) {
      context.read<LessonsCubit>().loadLessons(groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _link(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 17.5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 7.5.r),
        decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: ProjectShadow.boxShadow1,
        ),
        child: Text(
          date,
          style: _textTheme.bodyText1?.copyWith(height: 0),
        ),
      ),
    );
  }
}
