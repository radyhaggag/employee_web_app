import 'package:flutter/material.dart';

class MainInputField extends StatelessWidget {
  const MainInputField({
    super.key,
    required this.label,
    required this.controller,
    this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: onTap != null,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
