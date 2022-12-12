import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
