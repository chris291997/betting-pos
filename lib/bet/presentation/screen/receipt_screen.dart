import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/print_receipt_button.dart';
import 'package:bet_pos/bet/presentation/component/receipt_pdf_view.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BetScreenWrapper(
      displayAppBar: false,
      content: const [
        ReceiptPdfView(),
      ],
      nextButton: const PrintReceiptButton(),
      onAppbarBackButtonPressed: () {},
    );
  }
}
