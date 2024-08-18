import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_payment_details.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/betted_fighter.dart';
import 'package:bet_pos/bet/presentation/component/payment_option.dart';
import 'package:bet_pos/bet/presentation/screen/receipt_screen.dart';
import 'package:flutter/material.dart';

class ConfirmBetScreen extends StatelessWidget {
  const ConfirmBetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetScreenWrapper(
      appBarTitle: 'Payment',
      content: const [
        BettedFighterCard(),
        SizedBox(
          height: 30,
        ),
        Divider(),
        SizedBox(
          height: 30,
        ),
        BetPaymentDetails(),
        SizedBox(
          height: 30,
        ),
        PaymentOption(),
        SizedBox(
          height: 30,
        ),
      ],
      nextButton: BetNextStepButton(
        label: 'Confirm Payment',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ReceiptScreen()));
        },
      ),
    );
  }
}
