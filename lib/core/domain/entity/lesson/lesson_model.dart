import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:intl/intl.dart';

class LessonModel extends Equatable {
  final int id;
  final int groupId;
  final UserModel teacher;
  final List<UserModel> visitingStudents;
  final num price;
  final num salary;
  final DateTime date;
  final String comment;
  final DateTime createdAt;

  String get stringDate => DateFormat('dd MMMM yyyy').format(date);

  LessonModel({
    required this.id,
    required this.groupId,
    required this.teacher,
    required this.visitingStudents,
    required this.price,
    required this.salary,
    required this.date,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      groupId,
      teacher,
      visitingStudents,
      price,
      salary,
      date,
      comment,
      createdAt,
    ];
  }
}
