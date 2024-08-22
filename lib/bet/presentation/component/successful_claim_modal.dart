import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _rewardSVG = 'assets/svg/reward.svg';

void showSuccessClaimDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                _rewardSVG,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 20),
              Text(
                'Successfully Claimed',
                style: context.textStyle.subtitle1,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          BetNextStepButton(
            label: 'Go Back',
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      );
    },
  );
}
