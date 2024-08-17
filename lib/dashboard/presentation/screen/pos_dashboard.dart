import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {},
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
