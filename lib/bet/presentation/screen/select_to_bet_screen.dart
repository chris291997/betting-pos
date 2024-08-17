import 'package:bet_pos/bet/presentation/component/bet_fighters.dart';
import 'package:bet_pos/bet/presentation/component/bet_form_field.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/event_dropdown.dart';
import 'package:bet_pos/bet/presentation/component/fighter_dropdown.dart';
import 'package:flutter/material.dart';

class SelectToBetScreen extends StatelessWidget {
  const SelectToBetScreen({super.key});

  static const routeName = '/bet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bet Details'),
            const EventDropdown(),
            const FighterDropdown(),
            const BetFighters(),
            const BetFormField(),
            BetNextStepButton(
              label: 'Continue',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
