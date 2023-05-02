import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/app/router/router.dart';
import 'package:crm/features/common/lessons/features/lesson/view/lesson_screen.dart';
import 'package:crm/features/common/lessons/features/lessons/cubit/lessons_cubit.dart';
import 'package:crm/features/common/lessons/features/lessons/view/widgets/lessons_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonsScreenArguments {
  final int id;
  final String groupName;

  LessonsScreenArguments({
    required this.id,
    required this.groupName,
  });
}

class LessonsScreen extends StatelessWidget {
  final LessonsCubit cubit;

  const LessonsScreen({super.key, required this.cubit});

  void _listener(
    BuildContext context,
    LessonsState state,
  ) {
    final _l10n = context.l10n;

    if (state.isFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
  }

  Future<void> _createLessonLink(BuildContext context, int groupId) async {
    final data = await Navigator.pushNamed(
      context,
      Routes.lesson,
      arguments: LessonScreenArguments(groupId: groupId),
    );

    if (data != null) {
      context.read<LessonsCubit>().loadLessons(groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenArguments =
        ModalRoute.of(context)?.settings.arguments as LessonsScreenArguments;
    final groupId = _screenArguments.id;

    return BlocProvider<LessonsCubit>(
      create: (_) => cubit..loadLessons(groupId),
      child: BlocConsumer<LessonsCubit, LessonsState>(
        listener: _listener,
        builder: (context, state) => Scaffold(
          body: Scaffold(
            appBar: CustomAppBar(
              title: _screenArguments.groupName,
            ),
            body: _ScreenData(
              groupId: groupId,
              state: state,
            ),
            floatingActionButton: CustomFloatingActionButton(
              action: () => _createLessonLink(context, groupId),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatelessWidget {
  final int groupId;
  final LessonsState state;

  const _ScreenData({
    required this.groupId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      vertical: ProjectMargin.contentTop,
      horizontal: ProjectMargin.contentHorizontal,
    );

    return state.isScreenLoading
        ? ListView.builder(
            padding: padding,
            itemBuilder: (context, i) => ShimmerContainer(
              width: double.infinity,
              height: 35.h,
              margin: EdgeInsets.only(bottom: 17.5.h),
            ),
            itemCount: 30,
          )
        : ListView.builder(
            padding: padding,
            shrinkWrap: true,
            itemBuilder: (context, i) => LessonsCard(
              groupId: groupId,
              lessonId: state.lessons![i].id,
              date: state.lessons![i].stringDate,
            ),
            itemCount: state.lessons!.length,
          );
  }
}
