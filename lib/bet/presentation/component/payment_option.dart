import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({super.key});

  static const _moneySVG = 'assets/svg/money.svg';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment', style: context.textStyle.subtitle1),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lightGreen,
            ),
          ),
          padding: EdgeInsets.all(
            context.layout.mediumPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                _moneySVG,
                height: 28,
                width: 28,
                fit: BoxFit.contain,
              ),
              Text('Cash', style: context.textStyle.subtitle2),
            ],
          ),
        )
      ],
    );
  }
}
