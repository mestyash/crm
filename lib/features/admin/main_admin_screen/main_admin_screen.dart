import 'package:crm/core/presentation/ui/main_nav_bar/main_nav_bar.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/staff_screen/view/staff_screen.dart';
import 'package:crm/features/admin/students/features/students_screen/cubit/students_cubit.dart';
import 'package:crm/features/admin/students/features/students_screen/view/students_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAdminScreen extends StatefulWidget {
  final StaffCubit staffCubit;
  final StudentsCubit studentsCubit;

  const MainAdminScreen({
    super.key,
    required this.staffCubit,
    required this.studentsCubit,
  });

  @override
  State<MainAdminScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainAdminScreen> {
  late StaffScreen _staffScreen;
  late StudentsScreen _studentsScreen;

  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _staffScreen = StaffScreen();
    _studentsScreen = StudentsScreen();

    _pages = [
      BlocProvider<StaffCubit>(
        create: (_) => widget.staffCubit..loadStaffData(),
        child: _staffScreen,
      ),
      BlocProvider<StudentsCubit>(
        create: (_) => widget.studentsCubit..loadStudents(),
        child: _studentsScreen,
      ),
    ];
    super.initState();
  }

  void onPageChanged(int index) {
    if (_selectedIndex != index) setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: MainNavBar(
        selectedIndex: _selectedIndex,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
