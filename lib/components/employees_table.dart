import 'package:employee_web_app/cubit/employee_cubit.dart';
import 'package:employee_web_app/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesTable extends StatelessWidget {
  const EmployeesTable({super.key, this.onEdit});

  final Function(EmployeeModel)? onEdit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<EmployeeCubit>();
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return DataTable(
          columns: const [
            DataColumn(label: Text("Code")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Birthday")),
            DataColumn(label: Text("Salary")),
            DataColumn(label: Text("Gender")),
            DataColumn(label: Text("Attachments")),
            DataColumn(label: Text("Actions")),
          ],
          rows: cubit.employees.map((employee) {
            return DataRow(
              cells: [
                DataCell(Text(employee.empCode)),
                DataCell(Text(employee.empName)),
                DataCell(Text(employee.empBirthday)),
                DataCell(Text(employee.empSalary.toString())),
                DataCell(Text(employee.empGender)),
                DataCell(Text(employee.attachmentsPaths.length.toString())),
                DataCell(
                  Row(
                    children: [
                      TextButton(
                        child: Text("Edit"),
                        onPressed: () {
                          onEdit?.call(employee);
                        },
                      ),
                      TextButton(
                        child: Text("Delete"),
                        onPressed: () {
                          cubit.deleteEmployee(
                            cubit.employees.indexOf(employee),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Employee deleted successfully!"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
