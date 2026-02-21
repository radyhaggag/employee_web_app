import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/employee_model.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  final List<EmployeeModel> employees = [];

  void loadEmployees() {
    employees.clear();

    Hive.box<EmployeeModel>('employees').values.toList().forEach((employee) {
      employees.add(employee);
    });

    emit(EmployeeLoaded(employees));
  }

  void addEmployee(EmployeeModel employee) {
    if (employees.any((e) => e.empCode == employee.empCode)) {
      updateEmployee(employee); 
      return;
    }
    Hive.box<EmployeeModel>('employees').add(employee);
    employees.add(employee);
    emit(EmployeeLoaded(List.from(employees)));
  }

  void updateEmployee(EmployeeModel employee, {String? oldCode}) {
    final index = employees.indexWhere((e) => e.empCode == employee.empCode || e.empCode == oldCode);
    if (index != -1) {
      employees[index] = employee;
      Hive.box<EmployeeModel>('employees').putAt(index, employee);
      emit(EmployeeLoaded(List.from(employees)));
    }
  }

  void deleteEmployee(int index) {
    if (index >= 0 && index < employees.length) {
      employees.removeAt(index);
      Hive.box<EmployeeModel>('employees').deleteAt(index);
      emit(DeleteEmployeeState(index));
    }
  }
}
