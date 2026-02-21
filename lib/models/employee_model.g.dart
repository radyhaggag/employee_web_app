// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeModelAdapter extends TypeAdapter<EmployeeModel> {
  @override
  final int typeId = 0;

  @override
  EmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeModel(
      empCode: fields[0] as String,
      empName: fields[1] as String,
      empBirthday: fields[2] as String,
      empSalary: fields[3] as double,
      empGender: fields[4] as String,
      attachmentsPaths: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.empCode)
      ..writeByte(1)
      ..write(obj.empName)
      ..writeByte(2)
      ..write(obj.empBirthday)
      ..writeByte(3)
      ..write(obj.empSalary)
      ..writeByte(4)
      ..write(obj.empGender)
      ..writeByte(5)
      ..write(obj.attachmentsPaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
