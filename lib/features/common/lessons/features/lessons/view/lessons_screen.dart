import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:crm/core/presentation/ui/shimmer_container/shimmer_container.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/lessons/features/lessons/cubit/lessons_cubit.dart';
import 'package:crm/features/common/lessons/features/lessons/view/widgets/lessons_card.dart';
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

  @override
  Widget build(BuildContext context) {
    final _screenArguments =
        ModalRoute.of(context)?.settings.arguments as LessonsScreenArguments;

    return BlocProvider<LessonsCubit>(
      create: (_) => cubit..loadLessons(),
      child: BlocConsumer<LessonsCubit, LessonsState>(
        listener: (context, state) => {},
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(
            title: _screenArguments.groupName,
          ),
          body: _ScreenData(state: state),
          floatingActionButton: CustomFloatingActionButton(
            action: () => {},
          ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatelessWidget {
  final LessonsState state;

  const _ScreenData({required this.state});

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
              lessonId: state.lessons![i].id,
              date: state.lessons![i].stringDate,
            ),
            itemCount: state.lessons!.length,
          );
  }
}
