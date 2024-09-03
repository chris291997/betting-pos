import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card_v2.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BettedFighterCardV2 extends StatelessWidget {
  const BettedFighterCardV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetBloc, BetState, FighterType>(
      selector: (state) {
        return state.input.betOnByType;
      },
      builder: (context, betOnByType) {
        return SelectBetCardV2(
          fighterType: betOnByType,
          isSelected: true,
          onTap: () {},
        );
      },
    );
  }
}
