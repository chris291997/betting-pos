import 'package:bet_pos/common/component/card/base_card.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  static const _svgAssetPathForWala = 'assets/svg/wala.svg';
  static const _svgAssetPathForMeron = 'assets/svg/meron.svg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                fighterType.isWala
                    ? _svgAssetPathForWala
                    : _svgAssetPathForMeron,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fighterOutput.name, style: context.textStyle.subtitle1),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Breed: ${fighterOutput.breed}',
                      style: context.textStyle.caption),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      'Weight: ${fighterOutput.weight}',
                      style: context.textStyle.caption,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Trainer: ${fighterOutput.trainer}',
                    style: context.textStyle.caption,
                  ),
                ],
              ),
            ],
          ),
          Text(fighterType.name.toUpperCase(),
              style: context.textStyle.headline6),
        ],
      ),
    );
  }
}
