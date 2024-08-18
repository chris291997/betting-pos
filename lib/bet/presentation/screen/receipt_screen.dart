import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/print_receipt_button.dart';
import 'package:bet_pos/bet/presentation/component/receipt_pdf_view.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key, required this.betOutput});

  final BetOutput betOutput;

  @override
  Widget build(BuildContext context) {
    return BetScreenWrapper(
      displayAppBar: false,
      content: [
        ReceiptPdfView(
          betOutput: betOutput,
        ),
      ],
      nextButton: const PrintReceiptButton(),
      onAppbarBackButtonPressed: () {},
    );
  }
}
