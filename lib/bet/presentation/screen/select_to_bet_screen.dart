import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_continue_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_fighters.dart';
import 'package:bet_pos/bet/presentation/component/bet_form_field.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/event_dropdown.dart';
import 'package:bet_pos/bet/presentation/component/fight_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectToBetScreen extends StatelessWidget {
  const SelectToBetScreen({super.key});

  static const routeName = '/bet';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BetBloc(betRepository),
      child: BetScreenWrapper(
        appBarTitle: 'Place Your Bet',
        content: const [
          Text('Bet Details'),
          SizedBox(height: 50),
          EventDropdown(),
          SizedBox(height: 20),
          FightDropdown(),
          SizedBox(height: 20),
          BetFighters(),
          SizedBox(height: 20),
          BetFormField(),
          SizedBox(height: 20),
        ],
        nextButton: const BetContinueButton(),
        onAppbarBackButtonPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        },
      ),
    );
  }
}
