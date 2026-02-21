import 'package:employee_web_app/enums/gender.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    super.key,
    required this.onGenderSelected,
    this.selectedGender,
  });

  final Function(Gender?) onGenderSelected;
  final Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black87),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<Gender>(
        items: Gender.values.map((gender) {
          return DropdownMenuItem<Gender>(
            value: gender,
            child: Text(gender.name),
          );
        }).toList(),
        onChanged: (value) {
          onGenderSelected(value);
        },
        value: selectedGender,
        hint: const Text("Select Gender"),
        isExpanded: true,
        underline: SizedBox.shrink(),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
