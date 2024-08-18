import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:flutter/material.dart';

class DownloadReceiptButton extends StatelessWidget {
  const DownloadReceiptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Download',
      onPressed: () {},
    );
  }
}
