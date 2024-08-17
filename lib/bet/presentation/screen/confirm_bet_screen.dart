import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_payment_details.dart';
import 'package:bet_pos/bet/presentation/component/payment_option.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';

class ConfirmBetScreen extends StatelessWidget {
  const ConfirmBetScreen({
    super.key,
    required this.selectedFighterType,
  });

  final FighterType selectedFighterType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectBetCard(
                fighterOutput: FighterOutput.empty,
                fighterType: selectedFighterType,
                isSelected: true,
                onTap: () {}),
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
    );
  }
}
