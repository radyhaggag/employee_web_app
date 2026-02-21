import 'package:hive_flutter/hive_flutter.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends HiveObject {
  @HiveField(0)
  String empCode;

  @HiveField(1)
  String empName;

  @HiveField(2)
  String empBirthday;

  @HiveField(3)
  double empSalary;

  @HiveField(4)
  String empGender;

  @HiveField(5)
  List<String> attachmentsPaths;

  EmployeeModel({
    required this.empCode,
    required this.empName,
    required this.empBirthday,
    required this.empSalary,
    required this.empGender,
    required this.attachmentsPaths,
  });
}
