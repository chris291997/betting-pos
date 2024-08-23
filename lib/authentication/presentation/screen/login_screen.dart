import 'package:bet_pos/authentication/presentation/component/login_form.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.layout.smallPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Betting App', style: context.textStyle.headline4),
              Gap(context.layout.largeSpacing),
              const Expanded(
                child: Center(
                  child: LoginForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
