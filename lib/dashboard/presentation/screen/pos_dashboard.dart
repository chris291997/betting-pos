import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PosDashboard extends StatelessWidget {
  const PosDashboard({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            onPressed: () {
              context.go(SelectToBetScreen.routeName);
            },
            labelText: 'Transact',
          ),
          PrimaryButton(
            onPressed: () {},
            labelText: 'Payout',
          )
        ],
      )),
    );
  }
}
