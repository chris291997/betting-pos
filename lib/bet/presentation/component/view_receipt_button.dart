import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:flutter/material.dart';

class ViewReceiptButton extends StatelessWidget {
  const ViewReceiptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'View Receipt',
      onPressed: () {},
    );
  }
}
