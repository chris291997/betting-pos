import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BettedFighterCard extends StatelessWidget {
  const BettedFighterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetBloc, BetState, BetInput>(
      selector: (state) {
        return state.input;
      },
      builder: (context, betInput) {
        return SelectBetCard(
          fighterOutput: betInput.betOn,
          fighterType: betInput.fighterType ?? FighterType.wala,
          isSelected: true,
          onTap: () {},
        );
      },
    );
  }
}
