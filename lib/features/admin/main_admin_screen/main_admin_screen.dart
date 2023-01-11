import 'package:crm/core/presentation/ui/main_nav_bar/main_nav_bar.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/staff_screen/view/staff_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAdminScreen extends StatefulWidget {
  final StaffCubit staffCubit;

  const MainAdminScreen({
    super.key,
    required this.staffCubit,
  });

  @override
  State<MainAdminScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainAdminScreen> {
  late StaffScreen _staffScreen;

  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _staffScreen = StaffScreen();

    _pages = [
      BlocProvider<StaffCubit>(
        create: (_) => widget.staffCubit..loadStaffData(),
        child: _staffScreen,
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
