import 'package:bet_pos/bet/presentation/screen/search_bet_screen.dart';
import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen_v2.dart';
import 'package:bet_pos/common/component/appbar/main_appbar.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/theme/screen_size/screen_breakpoint.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PosDashboard extends StatelessWidget {
  const PosDashboard({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(
        title: 'Dashboard',
        showBackButton: false,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: ScreenBreakpoint.tabletMaxWidth,
          ),
          padding: EdgeInsets.all(context.layout.mediumPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryButton(
                onPressed: () {
                  context.push(SelectToBetScreenV2.routeName);
                },
                labelText: 'Place Bet',
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                onPressed: () {
                  context.push(SearchBetScreen.routeName);
                },
                labelText: 'View Transaction',
              )
            ],
          ),
        ),
      ),
    );
  }
}
