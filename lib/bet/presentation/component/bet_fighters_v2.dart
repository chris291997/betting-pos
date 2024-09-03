import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card_v2.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BetFightersV2 extends StatelessWidget {
  const BetFightersV2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetBloc, BetState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectBetCardV2(
              fighterType: FighterType.wala,
              isSelected: state.input.betOnByType.isWala,
              onTap: () {
                context.read<BetBloc>().add(
                      const BetFighterSelectedByType(FighterType.wala),
                    );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SelectBetCardV2(
              fighterType: FighterType.meron,
              isSelected: state.input.betOnByType.isMeron,
              onTap: () {
                context.read<BetBloc>().add(
                      const BetFighterSelectedByType(FighterType.meron),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
