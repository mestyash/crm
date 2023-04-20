part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class GroupEventLoad extends GroupEvent {
  final int? id;

  GroupEventLoad({required this.id});

  @override
  List<Object?> get props => [id];
}

class GroupEventName extends GroupEvent {
  final String name;

  GroupEventName({required this.name});

  @override
  List<Object> get props => [name];
}

class GroupEventLanguage extends GroupEvent {
  final int language;

  GroupEventLanguage({required this.language});

  @override
  List<Object> get props => [language];
}

class GroupEventSearchTeacher extends GroupEvent {
  final String surname;

  GroupEventSearchTeacher({required this.surname});

  @override
  List<Object> get props => [surname];
}

class GroupEventSelectTeacher extends GroupEvent {
  final UserModel teacher;

  GroupEventSelectTeacher({required this.teacher});

  @override
  List<Object> get props => [teacher];
}

class GroupEventSearchStudent extends GroupEvent {
  final String surname;

  GroupEventSearchStudent({required this.surname});

  @override
  List<Object> get props => [surname];
}

class GroupEventSelectStudent extends GroupEvent {
  final UserModel student;

  GroupEventSelectStudent({required this.student});

  @override
  List<Object> get props => [student];
}

class GroupEventRemoveStudent extends GroupEvent {
  final int id;

  GroupEventRemoveStudent({required this.id});

  @override
  List<Object> get props => [id];
}

class GroupEventPrice extends GroupEvent {
  final String price;

  GroupEventPrice({required this.price});

  @override
  List<Object> get props => [price];
}

class GroupEventSalary extends GroupEvent {
  final String salary;

  GroupEventSalary({required this.salary});

  @override
  List<Object> get props => [salary];
}

class GroupEventActive extends GroupEvent {
  GroupEventActive();
}

class GroupEventUpload extends GroupEvent {
  GroupEventUpload();
}
