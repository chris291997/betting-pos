import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    this.labelText = '',
    this.label,
    this.state = PrimaryButtonState.enabled,
    this.height,
    super.key,
  });

  final Widget? label;
  final double? height;
  final String labelText;
  final void Function() onPressed;
  final PrimaryButtonState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: context.layout.mediumPadding,
            horizontal: context.layout.largePadding,
          ),
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.layout.largeRadius),
          ),
        ),
        onPressed: state.isEnabled ? onPressed : null,
        child: state.isLoading
            ? const CircularProgressIndicator()
            : label ?? Text(labelText, style: context.textStyle.button),
      ),
    );
  }
}

enum PrimaryButtonState {
  enabled,
  disabled,
  loading;

  bool get isEnabled => this == PrimaryButtonState.enabled;

  bool get isDisabled => this == PrimaryButtonState.disabled;

  bool get isLoading => this == PrimaryButtonState.loading;
}
