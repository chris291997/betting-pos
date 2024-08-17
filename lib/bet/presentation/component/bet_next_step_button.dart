import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

class BetNextStepButton extends StatelessWidget {
  const BetNextStepButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      labelText: label,
      onPressed: onPressed,
    );
  }
}
