import 'package:crm/core/domain/entity/user_model.dart';

abstract class IStudentsRepository {
  Future<List<UserModel>> getStudents();
  Future<void> deleteStudent({required int id});
  Future<UserModel> getStudent({required int id});
  Future<void> uploadStudent(UploadStudentParams params);
}

class UploadStudentParams {
  final int? id;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthday;

  UploadStudentParams({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
  });
}
