import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/dashboard/presentation/screen/pos_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Done',
      onPressed: () {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        context.go(PosDashboard.routeName);
      },
    );
  }
}
