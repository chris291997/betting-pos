import 'package:bet_pos/bet/presentation/component/select_bet_card.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';

class BetFighters extends StatelessWidget {
  const BetFighters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectBetCard(
          fighterOutput: FighterOutput.empty,
          fighterType: FighterType.wala,
          isSelected: false,
          onTap: () {},
        ),
        SelectBetCard(
          fighterOutput: FighterOutput.empty,
          fighterType: FighterType.meron,
          isSelected: true,
          onTap: () {},
        ),
      ],
    );
  }
}
