import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_payment_details.dart';
import 'package:bet_pos/bet/presentation/component/betted_fighter.dart';
import 'package:bet_pos/bet/presentation/component/payment_option.dart';
import 'package:flutter/material.dart';

class ConfirmBetScreen extends StatelessWidget {
  const ConfirmBetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BettedFighterCard(),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 30,
              ),
              const BetPaymentDetails(),
              const SizedBox(
                height: 30,
              ),
              const PaymentOption(),
              const SizedBox(
                height: 30,
              ),
              BetNextStepButton(
                label: 'Confirm Payment',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
