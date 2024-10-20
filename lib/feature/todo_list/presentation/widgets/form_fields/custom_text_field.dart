import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

/// A customizable text field widget for user input.
///
/// This widget is a wrapper around [TextFormField] that allows
/// customization of label text, hint text, read-only state,
/// and additional parameters like a suffix icon and validation.
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.readonly = false,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.validator,
  });

  /// The text to display as the label of the text field.
  final String labelText;

  /// The text to display as a hint inside the text field.
  final String hintText;

  /// Whether the text field is read-only.
  final bool readonly;

  /// An optional widget displayed at the end of the text field.
  final Widget? suffixIcon;

  /// An optional controller to manage the text input.
  final TextEditingController? controller;

  /// A callback called when the text changes.
  final void Function(String)? onChanged;

  /// A function that validates the text input and returns an error message
  /// if the input is invalid.
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
