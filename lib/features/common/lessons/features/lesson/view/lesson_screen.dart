import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/lessons/features/lesson/cubit/lesson_cubit.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonScreenArguments {
  final int groupId;
  final int? lessonId;

  LessonScreenArguments({
    required this.groupId,
    this.lessonId,
  });
}

class LessonScreen extends StatelessWidget {
  final LessonCubit cubit;

  const LessonScreen({super.key, required this.cubit});

  void _listener(
    BuildContext context,
    LessonState state,
  ) {
    final _l10n = context.l10n;
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return BlocProvider<LessonCubit>(
      create: (_) => cubit,
      child: BlocConsumer<LessonCubit, LessonState>(
        listener: _listener,
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(
            title: _l10n.lesson,
            actions: [
              Visibility(
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.delete,
                    size: 20.r,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          body: state.isLoading
              ? LoadingIndicator()
              : _ScreenData(
                  state: state,
                ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatefulWidget {
  final LessonState state;

  const _ScreenData({required this.state});

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late LessonCubit _cubit;
  late TextEditingController _teacherController;
  late TextEditingController _salaryController;
  late TextEditingController _priceController;
  late TextEditingController _commentController;

  @override
  void initState() {
    _cubit = context.read<LessonCubit>();
    _teacherController = TextEditingController();
    _salaryController = TextEditingController();
    _priceController = TextEditingController();
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _teacherController.dispose();
    _salaryController.dispose();
    _priceController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final isAdmin = context.select((CurrentUserCubit e) => e.state!.isAdmin);

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: ProjectMargin.contentHorizontal,
        vertical: ProjectMargin.contentTop,
      ),
      children: [
        InputText(
          title: _l10n.teacher,
          controller: _teacherController,
          readOnly: true,
        ),
        InputText(
          title: _l10n.salary,
          controller: _salaryController,
          readOnly: true,
        ),
        Visibility(
          visible: isAdmin,
          child: InputText(
            title: _l10n.price,
            controller: _priceController,
            readOnly: true,
          ),
        ),
        InputText(
          title: _l10n.comment,
          minLines: 3,
          controller: _commentController,
        ),
        CustomElevatedButton(text: _l10n.save, onTap: () {})
      ],
    );
  }
}
