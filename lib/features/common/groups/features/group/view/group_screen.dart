import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_checkbox/input_checkbox.dart';
import 'package:crm/core/presentation/ui/inputs/input_select/input_select.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/loading_indicator/loading_indicator.dart';
import 'package:crm/core/presentation/ui/search_users_modal_sheet/search_users_modal_sheet.dart';
import 'package:crm/core/presentation/ui/snackbar/snackbar.dart';
import 'package:crm/core/settings/language/language_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/common/groups/features/group/bloc/group_bloc.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GroupScreenScreenArguments {
  final int id;
  GroupScreenScreenArguments({required this.id});
}

class GroupScreen extends StatelessWidget {
  final GroupBloc bloc;

  const GroupScreen({super.key, required this.bloc});

  void _listener(BuildContext context, GroupState state) {
    final _l10n = context.l10n;
    if (state.isUploading) {
      context.loaderOverlay.show();
    }
    if (state.successfullyCreated) {
      context.loaderOverlay.hide();
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.success(
          text: _l10n.groupScreenSuccessfullyCreated,
        ));
    }
    if (state.textFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(text: _l10n.dataError));
    }
    if (state.isFailure) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(AppSnackBar.failure(
          text: _l10n.error,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenArguments = ModalRoute.of(context)?.settings.arguments
        as GroupScreenScreenArguments?;

    final _l10n = context.l10n;

    return BlocProvider<GroupBloc>(
      create: (_) => bloc..add(GroupEventLoad(id: _screenArguments?.id)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: _l10n.mainAdminNavBarGroups,
        ),
        body: BlocConsumer<GroupBloc, GroupState>(
          listener: _listener,
          builder: (context, state) => state.isLoading
              ? LoadingIndicator()
              : _ScreenData(
                  state: state,
                  languages: LanguageSettings.stringLanguages(_l10n),
                ),
        ),
      ),
    );
  }
}

class _ScreenData extends StatefulWidget {
  final GroupState state;
  final List<String> languages;

  const _ScreenData({
    required this.state,
    required this.languages,
  });

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late GroupBloc _bloc;
  late TextEditingController _nameController;
  late TextEditingController _teacherController;
  late TextEditingController _priceController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    final state = widget.state;
    _bloc = context.read<GroupBloc>();
    _nameController = TextEditingController()..text = state.name;
    _teacherController = TextEditingController()
      ..text = state.teacher?.fullName ?? '';
    _priceController = TextEditingController()
      ..text = state.price == 0 ? '' : state.price.toString();
    _salaryController = TextEditingController()
      ..text = state.salary == 0 ? '' : state.salary.toString();
    super.initState();
  }

  void _onLanguageChange(int? value) {
    _bloc.add(GroupEventLanguage(language: value!));
  }

  void _onTeacherSelect(UserModel teacher) {
    _teacherController.text = teacher.fullName;
    _bloc.add(GroupEventSelectTeacher(teacher: teacher));
  }

  void _searchTeacherSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<GroupBloc>.value(
        value: _bloc,
        child: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return SearchUsersModalSheet(
              onTextChange: (surname) => _bloc.add(
                GroupEventSearchTeacher(surname: surname),
              ),
              isLoading: state.isSearching,
              users: state.availableTeachers,
              onSelectUser: _onTeacherSelect,
            );
          },
        ),
      ),
    );
  }

  void _searchStudentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<GroupBloc>.value(
        value: _bloc,
        child: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return SearchUsersModalSheet(
              onTextChange: (surname) => _bloc.add(
                GroupEventSearchStudent(surname: surname),
              ),
              isLoading: state.isSearching,
              users: state.availableStudents,
              onSelectUser: (user) => _bloc.add(
                GroupEventSelectStudent(student: user),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _teacherController.dispose();
    _priceController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _textTheme = Theme.of(context).textTheme;

    final _languages = LanguageSettings.languages;
    final isAdmin = context.select((CurrentUserCubit e) => e.state!.isAdmin);
    final state = widget.state;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ProjectMargin.contentHorizontal,
          vertical: ProjectMargin.contentTop,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputText(
              title: _l10n.name,
              hintText: _l10n.enterName,
              controller: _nameController,
              onChange: (text) => _bloc.add(GroupEventName(name: text)),
              readOnly: !isAdmin,
            ),
            InputSelect<int>(
              title: _l10n.language,
              hintText: _l10n.selectLanguage,
              selectedValue: state.language,
              valueNames: widget.languages,
              values: _languages,
              onChange: _onLanguageChange,
              readOnly: !isAdmin,
            ),
            InputText(
              title: _l10n.teacher,
              hintText: _l10n.selectTeacher,
              readOnly: true,
              controller: _teacherController,
              onTap: _searchTeacherSheet,
            ),
            Visibility(
              visible: isAdmin,
              child: InputText(
                title: _l10n.price,
                hintText: _l10n.enterPrice,
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChange: (sum) => _bloc.add(GroupEventPrice(price: sum)),
              ),
            ),
            InputText(
              title: _l10n.salary,
              hintText: _l10n.enterSalary,
              controller: _salaryController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChange: (sum) => _bloc.add(GroupEventSalary(salary: sum)),
            ),
            Visibility(
              visible: isAdmin,
              child: InputCheckbox(
                action: () => _bloc.add(GroupEventActive()),
                isSelected: state.isActive,
                text: _l10n.groupScreenCheckbox,
              ),
            ),
            Wrap(
              spacing: 10.w,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...state.students.map(
                  (e) => Chip(
                    padding: EdgeInsets.zero,
                    label: Text(
                      e.fullName1,
                      style: _textTheme.bodyLarge?.copyWith(height: 0),
                    ),
                    onDeleted: isAdmin
                        ? () => _bloc.add(GroupEventRemoveStudent(id: e.id))
                        : null,
                  ),
                ),
                GestureDetector(
                  onTap: _searchStudentSheet,
                  child: Icon(
                    Icons.add,
                    size: 25.r,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              text: _l10n.save.toUpperCase(),
              onTap: state.canSend ? () => _bloc.add(GroupEventUpload()) : null,
            ),
          ],
        ),
      ),
    );
  }
}
