import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_continue_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_fighters.dart';
import 'package:bet_pos/bet/presentation/component/bet_form_field.dart';
import 'package:bet_pos/bet/presentation/component/event_dropdown.dart';
import 'package:bet_pos/bet/presentation/component/fight_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectToBetScreen extends StatelessWidget {
  const SelectToBetScreen({super.key});

  static const routeName = '/bet';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BetBloc(betRepository),
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bet Details'),
                EventDropdown(),
                FightDropdown(),
                BetFighters(),
                BetFormField(),
                BetContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
