import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:flutter/material.dart';

class PrintReceiptButton extends StatelessWidget {
  const PrintReceiptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Use Thermal Printer',
      onPressed: () {},
    );
  }
}
