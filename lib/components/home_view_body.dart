import 'dart:io';

import 'package:employee_web_app/components/attachments_section.dart';
import 'package:employee_web_app/components/employees_table.dart';
import 'package:employee_web_app/components/gender_picker.dart';
import 'package:employee_web_app/components/main_input_field.dart';
import 'package:employee_web_app/cubit/employee_cubit.dart';
import 'package:employee_web_app/enums/gender.dart';
import 'package:employee_web_app/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController _empNameController = TextEditingController();
  final TextEditingController _empCodeController = TextEditingController();
  final TextEditingController _empBirthdayController = TextEditingController();
  final TextEditingController _empSalaryController = TextEditingController();
  Gender _selectedGender = Gender.male;
  List<File> _attachments = [];

  @override
  void dispose() {
    _empNameController.dispose();
    _empCodeController.dispose();
    _empBirthdayController.dispose();
    _empSalaryController.dispose();
    super.dispose();
  }

  bool isEditMode = false;
  String? oldEmpCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainInputField(controller: _empCodeController, label: "Employee Code"),
        const SizedBox(height: 16),
        MainInputField(controller: _empNameController, label: "Employee Name"),
        const SizedBox(height: 16),
        MainInputField(
          controller: _empBirthdayController,
          label: "Employee Birthday",
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 16),
        GenderPicker(
          onGenderSelected: (gender) {
            if (gender != null) setState(() => _selectedGender = gender);
          },
          selectedGender: _selectedGender,
        ),
        const SizedBox(height: 16),
        MainInputField(
          controller: _empSalaryController,
          label: "Employee Salary",
        ),
        const SizedBox(height: 16),
        AttachmentsSection(
          onAddAttachment: (files) {
            setState(() => _attachments = files);
          },
          attachments: _attachments,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final emp = EmployeeModel(
              empCode: _empCodeController.text,
              empName: _empNameController.text,
              empBirthday: _empBirthdayController.text,
              empGender: _selectedGender.label.toString(),
              empSalary: double.tryParse(_empSalaryController.text) ?? 0.0,
              attachmentsPaths: _attachments.map((file) => file.path).toList(),
            );
            if (isEditMode) {
              context.read<EmployeeCubit>().updateEmployee(emp, oldCode: oldEmpCode);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Employee updated successfully!")),
              );
            } else {
              context.read<EmployeeCubit>().addEmployee(emp);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Employee added successfully!")),
              );
            }
            _empCodeController.clear();
            _empNameController.clear();
            _empBirthdayController.clear();
            _empSalaryController.clear();
            setState(() {
              _selectedGender = Gender.male;
              _attachments = [];
              isEditMode = false;
              oldEmpCode = null;
            });
          },
          child: Text(isEditMode ? "Update Employee" : "Add Employee"),
        ),
        EmployeesTable(
          onEdit: (employee) {
            setState(() {
              isEditMode = true;
              oldEmpCode = employee.empCode;
            });
            _empCodeController.text = employee.empCode;
            _empNameController.text = employee.empName;
            _empBirthdayController.text = employee.empBirthday;
            _empSalaryController.text = employee.empSalary.toString();
            _selectedGender = Gender.fromLabel(employee.empGender);
            _attachments = employee.attachmentsPaths
                .map((path) => File(path))
                .toList();
            setState(() {});
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _empBirthdayController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }
}
