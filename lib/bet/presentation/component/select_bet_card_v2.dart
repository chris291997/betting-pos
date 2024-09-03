import 'package:bet_pos/common/component/card/base_card.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';

class SelectBetCardV2 extends StatelessWidget {
  const SelectBetCardV2({
    super.key,
    required this.fighterType,
    required this.isSelected,
    required this.onTap,
  });

  final FighterType fighterType;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      color: fighterType.isMeron
          ? const Color(0xFF32CD32)
          : const Color(0xFFFF4500),
      enableGradientBorder: isSelected,
      content: _CardContent(
        fighterType: fighterType,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.fighterType,
  });

  final FighterType fighterType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text(
          fighterType.name.toUpperCase(),
          style: context.textStyle.headline6,
        ),
      ),
    );
  }
}
