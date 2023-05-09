import 'package:crm/features/common/groups/features/groups/cubit/groups_cubit.dart';
import 'package:crm/features/common/groups/features/groups/view/groups_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTeacherScreen extends StatefulWidget {
  final GroupsCubit groupsCubit;

  const MainTeacherScreen({
    super.key,
    required this.groupsCubit,
  });

  @override
  State<MainTeacherScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainTeacherScreen> {
  late GroupsScreen _groupsScreen;

  @override
  void initState() {
    _groupsScreen = GroupsScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupsCubit>(
      create: (_) => widget.groupsCubit..loadGroups(),
      child: _groupsScreen,
    );
  }
}
