import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_checkbox/input_checkbox.dart';
import 'package:crm/core/presentation/ui/inputs/input_select/input_select.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/presentation/ui/search_users_modal_sheet/search_users_modal_sheet.dart';
import 'package:crm/core/settings/language/language_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/students/features/upload_student/view/upload_student_screen.dart';
import 'package:crm/features/common/groups/features/group/bloc/group_bloc.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupScreenScreenArguments {
  final int id;
  GroupScreenScreenArguments({required this.id});
}

class GroupScreen extends StatelessWidget {
  final GroupBloc bloc;

  const GroupScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final _screenArguments = ModalRoute.of(context)?.settings.arguments
        as UploadStudentScreenArguments?;

    final _l10n = context.l10n;

    return BlocProvider<GroupBloc>(
      create: (_) => bloc..add(GroupEventLoad(id: _screenArguments?.id)),
      child: Scaffold(
        appBar: CustomAppBar(
          title: _l10n.mainAdminNavBarGroups,
        ),
        body: BlocConsumer<GroupBloc, GroupState>(
          listener: (context, state) => {},
          builder: (context, state) => _ScreenData(
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
  late TextEditingController _languageController;
  late TextEditingController _teacherController;
  late TextEditingController _priceController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    final state = widget.state;
    _bloc = context.read<GroupBloc>();
    _nameController = TextEditingController()..text = state.name;
    _languageController = TextEditingController()
      ..text = state.language == null ? '' : widget.languages[state.language!];
    _teacherController = TextEditingController()
      ..text = state.teacher?.fullName ?? '';
    _priceController = TextEditingController()..text = state.price.toString();
    _salaryController = TextEditingController()..text = state.salary.toString();
    super.initState();
  }

  void _onLanguageChange(int value) {
    _languageController.text = widget.languages[value];
    _bloc.add();
  }
  // void _openModalSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (_) => BlocProvider<GroupBloc>.value(
  //       value: _bloc,
  //       child: BlocBuilder<CreatePaymentBloc, CreatePaymentState>(
  //         builder: (context, state) {
  //           return SearchUsersModalSheet(
  //             onTextChange: _onSearchStudents,
  //             isLoading: state.isSearching,
  //             users: state.students,
  //             onSelectUser: _onStudentChange,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _languageController.dispose();
    _teacherController.dispose();
    _priceController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;
    final _languages = LanguageSettings.languages;
    final isAdmin = context.select((CurrentUserCubit e) => e.state!.isAdmin);

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
              selectedValue: null,
              valueNames: widget.languages
                  .map((e) => LanguageSettings.translateLanguage(_l10n, e))
                  .toList(),
              values: _languages,
              onChange: (place) => {},
              readOnly: !isAdmin,
            ),
            InputText(
              title: _l10n.teacher,
              hintText: _l10n.selectTeacher,
              readOnly: true,
              controller: _teacherController,
              onTap: () {},
            ),
            Visibility(
              visible: isAdmin,
              child: InputText(
                title: _l10n.price,
                hintText: _l10n.enterPrice,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChange: (sum) => {},
              ),
            ),
            InputText(
              title: _l10n.salary,
              hintText: _l10n.enterSalary,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChange: (sum) => {},
            ),
            Visibility(
              visible: isAdmin,
              child: InputCheckbox(
                action: () {},
                isSelected: true,
                text: _l10n.groupCheckbox,
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              text: _l10n.save.toUpperCase(),
              // onTap: widget.state.canSend ? () => _cubit.onUpload() : null,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}
