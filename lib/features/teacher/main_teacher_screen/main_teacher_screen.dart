import 'package:flutter/material.dart';

class MainTeacherScreen extends StatefulWidget {
  const MainTeacherScreen({super.key});

  @override
  State<MainTeacherScreen> createState() => _MainTeacherScreenState();
}

class _MainTeacherScreenState extends State<MainTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('main teacher screen'),
      ),
    );
  }
}
