import 'package:crm/core/presentation/blocs/current_user/current_user_cubit.dart';
import 'package:crm/core/presentation/ui/custom_app_bar/custom_app_bar.dart';
import 'package:crm/core/presentation/ui/cutom_elevated_button/custom_elevated_button.dart';
import 'package:crm/core/presentation/ui/inputs/input_checkbox/input_checkbox.dart';
import 'package:crm/core/presentation/ui/inputs/input_select/input_select.dart';
import 'package:crm/core/presentation/ui/inputs/input_text/input_text.dart';
import 'package:crm/core/settings/language/language_settings.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _l10n = context.l10n;

    return Scaffold(
      appBar: CustomAppBar(
        title: _l10n.mainAdminNavBarGroups,
      ),
      body: _ScreenData(),
    );
  }
}

class _ScreenData extends StatefulWidget {
  const _ScreenData();

  @override
  State<_ScreenData> createState() => _ScreenDataState();
}

class _ScreenDataState extends State<_ScreenData> {
  late TextEditingController _nameController;
  late TextEditingController _languageController;
  late TextEditingController _teacherController;
  late TextEditingController _priceController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _languageController = TextEditingController();
    _teacherController = TextEditingController();
    _priceController = TextEditingController();
    _salaryController = TextEditingController();
    super.initState();
  }

  void _openModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<CreatePaymentBloc>.value(
        value: _bloc,
        child: BlocBuilder<CreatePaymentBloc, CreatePaymentState>(
          builder: (context, state) {
            return SearchUsersModalSheet(
              onTextChange: _onSearchStudents,
              isLoading: state.isSearching,
              users: state.students,
              onSelectUser: _onStudentChange,
            );
          },
        ),
      ),
    );
  }

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
              // onChange: (text) => _cubit.onNameChange(text),
              readOnly: !isAdmin,
            ),
            InputSelect<int>(
              title: _l10n.language,
              hintText: _l10n.selectLanguage,
              selectedValue: null,
              valueNames: _languages
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
