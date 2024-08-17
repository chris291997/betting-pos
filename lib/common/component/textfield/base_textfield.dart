import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextfield extends StatelessWidget {
  const BaseTextfield({
    required this.onChanged,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: (value) => onChanged(value),
      style: context.textStyle.bodyText2.copyWith(
        color: context.colors.onBackground,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: context.textStyle.bodyText2.copyWith(
          color: context.colors.onBackground,
        ),
        hintText: hintText,
        hintStyle: context.textStyle.bodyText2.copyWith(
          color: context.colors.onBackground,
        ),
        filled: true,
        fillColor: context.colors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.layout.largeRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.layout.largeRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.layout.largeRadius),
          borderSide: BorderSide(
            color: context.colors.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.layout.largeRadius),
          borderSide: BorderSide(
            color: context.colors.error,
          ),
        ),
      ),
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
    );
  }
}
