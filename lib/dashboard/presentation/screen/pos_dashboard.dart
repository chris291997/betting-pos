import 'package:bet_pos/authentication/presentation/screen/login_screen.dart';
import 'package:bet_pos/bet/presentation/screen/search_bet_screen.dart';
import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen_v2.dart';
import 'package:bet_pos/common/component/appbar/main_appbar.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/common/service/device_info_service.dart';
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
      appBar: MainAppbar(
        title: 'Dashboard v${DeviceInfoService.version}',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: ScreenBreakpoint.tabletMaxWidth,
            ),
            padding: EdgeInsets.all(context.layout.mediumPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        onPressed: () {
                          context.go(SelectToBetScreenV2.routeName);
                        },
                        labelText: 'Place Bet',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(
                        onPressed: () {
                          context.go(SearchBetScreen.routeName);
                        },
                        labelText: 'View Transaction',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  onPressed: () async {
                    await cacheService.remove(StorageKey.accessToken);
                    await cacheService.remove(StorageKey.refreshToken);
                    await cacheService.remove(StorageKey.loggedUser);
                    if (context.mounted) {
                      context.go(LoginScreen.routeName);
                    }
                  },
                  labelText: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
