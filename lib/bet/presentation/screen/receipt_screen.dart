import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/done_button.dart';
import 'package:bet_pos/bet/presentation/component/print_receipt_button.dart';
import 'package:bet_pos/bet/presentation/component/receipt_pdf_view.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({
    super.key,
    required this.betOutput,
    required this.onDonePressed,
  });

  final BetOutput betOutput;
  final Function() onDonePressed;

  @override
  Widget build(BuildContext context) {
    return BetScreenWrapper(
      displayAppBar: false,
      canPop: false,
      content: [
        ReceiptPdfView(
          betOutput: betOutput,
        ),
      ],
      nextButtons: [
        PrintReceiptButton(
          betOutput: betOutput,
        ),
        const SizedBox(height: 10),
        DoneButton(
          onDonePressed: onDonePressed,
        ),
      ],
      onAppbarBackButtonPressed: () {},
    );
  }
}
