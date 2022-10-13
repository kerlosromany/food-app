import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CostumTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labText;
  final TextInputType textInputType;
  const CostumTextField({
    super.key,
    required this.controller,
    required this.labText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
      keyboardType: textInputType,
    );
  }
}
