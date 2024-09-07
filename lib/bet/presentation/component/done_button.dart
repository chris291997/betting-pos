import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    super.key,
    required this.onDonePressed,
  });

  final Function() onDonePressed;

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Done',
      onPressed: onDonePressed,
    );
  }
}
