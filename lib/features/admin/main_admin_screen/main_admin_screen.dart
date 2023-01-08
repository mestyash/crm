import 'package:crm/core/presentation/ui/main_nav_bar/main_nav_bar.dart';
import 'package:crm/features/admin/staff/staff_screen/presentation/view/staff_screen.dart';
import 'package:flutter/material.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

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
      _staffScreen,
      _staffScreen,
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
