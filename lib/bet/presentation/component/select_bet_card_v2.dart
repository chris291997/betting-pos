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
          ? const Color(0xFF1E90FF)
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
      height: 75,
      width: 75,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use this instead of Autosize or FittedBox to ensure that any character length will have the same font size
          double? getTextFontSize() {
            if (constraints.maxWidth < 75 && constraints.maxWidth > 60) {
              return 18;
            } else if (constraints.maxWidth <= 60) {
              return 16;
            }
            // return null to use the set or default fontsize
            return null;
          }

          return Center(
            child: Text(
              fighterType.name.toUpperCase(),
              style: context.textStyle.headline6
                  .copyWith(fontSize: getTextFontSize()),
            ),
          );
        },
      ),
    );
  }
}
