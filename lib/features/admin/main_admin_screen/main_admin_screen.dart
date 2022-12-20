import 'package:flutter/material.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('main admin screen'),
      ),
    );
  }
}
