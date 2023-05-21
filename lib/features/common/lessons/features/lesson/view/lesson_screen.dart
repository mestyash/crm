import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/delete_icon/delete_icon.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/lessons/features/lesson/cubit/lesson_cubit.dart';
import 'package:crm/features/common/lessons/features/lesson/view/widgets/lesson_student_card.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LessonScreenArguments {
  final int? groupId;
  final int? lessonId;

  LessonScreenArguments({
    this.groupId,
    this.lessonId,
  }) : assert(lessonId != null || groupId != null);
}

class LessonScreen extends StatelessWidget {
  final LessonCubit cubit;

  const LessonScreen({super.key, required this.cubit});

  void _listener(
    BuildContext context,
    LessonState state,
  ) {
    final _l10n = context.l10n;
    if (state.isUploading) {
      context.loaderOverlay.show();
    }
    if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.error));
    }
    if (state.successfullyCreated) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.lessonScreenSuccessfullyCreated,
        ));
    }
    if (state.successfullyDeleted) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.lessonScreenSuccessfullyDeleted,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _screenArguments =
        ModalRoute.of(context)?.settings.arguments as LessonScreenArguments;

    return BlocProvider<LessonCubit>(
      create: (_) => cubit
        ..loadInitialData(
          groupId: _screenArguments.groupId,
          lessonId: _screenArguments.lessonId,
        ),
      child: BlocConsumer<LessonCubit, LessonState>(
        listener: _listener,
        builder: (context, state) => Scaffold(
          appBar: CustomAppBar(
            title: _l10n.lesson,
            actions: [
              Visibility(
                visible: state.canDelete,
                child: DeleteIcon(
                  action: () => context.read<LessonCubit>().onDelete(),
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
    final group = widget.state.group;
    final lesson = widget.state.lesson;

    final teacherName =
        group?.teacher?.fullName ?? lesson?.teacher.fullName ?? '';
    final salary = (group?.salary ?? lesson?.salary ?? 0).toString();
    final price = (group?.price ?? lesson?.price ?? 0).toString();
    final comment = lesson?.comment ?? '';

    _cubit = context.read<LessonCubit>();
    _teacherController = TextEditingController()..text = teacherName;
    _salaryController = TextEditingController()..text = salary;
    _priceController = TextEditingController()..text = price;
    _commentController = TextEditingController()..text = comment;
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
    final state = widget.state;
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
        Column(
          children: state.group != null
              ? state.group!.students
                  .map(
                    (e) => LessonStudentCard(
                      name: e.fullName,
                      isSelected: state.studentIds.contains(e.id),
                      action: () => _cubit.onSelectStudent(e.id),
                    ),
                  )
                  .toList()
              : state.lesson!.visitingStudents
                  .map(
                    (e) => LessonStudentCard(
                      action: () {},
                      name: e.fullName,
                      isSelected: true,
                    ),
                  )
                  .toList(),
        ),
        InputText(
          title: _l10n.comment,
          minLines: 3,
          controller: _commentController,
          onChange: (t) => _cubit.onCommentChange(t),
          readOnly: !state.isCreating,
        ),
        Visibility(
          visible: state.isCreating,
          child: CustomElevatedButton(
            text: _l10n.save,
            onTap: state.canCreate ? () => _cubit.onUpload() : null,
          ),
        ),
      ],
    );
  }
}
