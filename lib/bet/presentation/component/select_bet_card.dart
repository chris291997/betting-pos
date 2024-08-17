import 'package:bet_pos/common/component/card/base_card.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';

class SelectBetCard extends StatelessWidget {
  const SelectBetCard({
    super.key,
    required this.fighterOutput,
    required this.fighterType,
    required this.isSelected,
    required this.onTap,
  });

  final FighterOutput fighterOutput;
  final FighterType fighterType;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      enableGradientBorder: isSelected,
      content: _CardContent(
        fighterOutput: fighterOutput,
        fighterType: fighterType,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.fighterOutput,
    required this.fighterType,
  });
  final FighterOutput fighterOutput;

  final FighterType fighterType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Row(
            children: [
              const Placeholder(
                fallbackHeight: 70,
                fallbackWidth: 70,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fighterOutput.name),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Breed: ${fighterOutput.breed}'),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    child: Text('Weight: ${fighterOutput.weight}'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Trainer: ${fighterOutput.trainer}'),
                ],
              ),
            ],
          ),
          Text(fighterType.name.toUpperCase()),
        ],
      ),
    );
  }
}
