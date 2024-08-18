import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/view_receipt_button.dart';
import 'package:flutter/material.dart';

class SuccessfulBetScreen extends StatelessWidget {
  const SuccessfulBetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BetScreenWrapper(
      displayAppBar: false,
      content: const [
        Text('Successful Payment'),
      ],
      nextButtons: const [ViewReceiptButton()],
      onAppbarBackButtonPressed: () {},
    );
  }
}
