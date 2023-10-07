import 'package:flutter/material.dart';

class QTextField extends StatefulWidget {
  final String label;
  final String? value;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final IconData? suffixIcon;

  const QTextField({
    Key? key,
    required this.label,
    this.value,
    this.validator,
    this.maxLength,
    this.enabled = true,
    this.suffixIcon,
    this.maxLines,
    this.minLines,
    this.controller,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<QTextField> createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget.label,
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        suffixIconColor: const Color(0xff4a3883),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xffE0E0E0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xffE0E0E0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xffE0E0E0),
          ),
        ),
      ),
    );
  }
}
