import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool error;
  final bool enabled;
  final bool obscureText;
  final int maxLines;
  final String? initialValue;

  const CommonTextField({
    Key? key,
    this.hintText,
    this.errorText,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.error = false,
    this.enabled = true,
    this.maxLines = 1,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      obscureText: obscureText,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }
}
