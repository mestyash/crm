import 'package:crm/features/admin/main_admin_screen/widgets/admin_nav_bar.dart';
import 'package:crm/features/admin/payments/features/payments_screen/bloc/payments_bloc.dart';
import 'package:crm/features/admin/payments/features/payments_screen/view/payments_screen.dart';
import 'package:crm/features/admin/staff/features/staff_screen/cubit/staff_cubit.dart';
import 'package:crm/features/admin/staff/features/staff_screen/view/staff_screen.dart';
import 'package:crm/features/admin/students/features/students_screen/cubit/students_cubit.dart';
import 'package:crm/features/admin/students/features/students_screen/view/students_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAdminScreen extends StatefulWidget {
  final StaffCubit staffCubit;
  final StudentsCubit studentsCubit;
  final PaymentsBloc paymentsBloc;

  const MainAdminScreen({
    super.key,
    required this.staffCubit,
    required this.studentsCubit,
    required this.paymentsBloc,
  });

  @override
  State<MainAdminScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainAdminScreen> {
  late StaffScreen _staffScreen;
  late StudentsScreen _studentsScreen;
  late PaymentsScreen _paymentsScreen;

  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _staffScreen = StaffScreen();
    _studentsScreen = StudentsScreen();
    _paymentsScreen = PaymentsScreen();

    _pages = [
      BlocProvider<StaffCubit>(
        create: (_) => widget.staffCubit..loadStaffData(),
        child: _staffScreen,
      ),
      BlocProvider<StudentsCubit>(
        create: (_) => widget.studentsCubit..loadStudents(),
        child: _studentsScreen,
      ),
      BlocProvider<PaymentsBloc>(
        create: (_) => widget.paymentsBloc,
        child: _paymentsScreen,
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
      bottomNavigationBar: AdminNavBar(
        selectedIndex: _selectedIndex,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
