part of 'employee_cubit.dart';

abstract class EmployeeState {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<EmployeeModel> employees;

  const EmployeeLoaded(this.employees);
}

class UpdateEmployeeState extends EmployeeState {
  final EmployeeModel employee;

  const UpdateEmployeeState(this.employee);
}

class DeleteEmployeeState extends EmployeeState {
  final int index;

  const DeleteEmployeeState(this.index);
}
