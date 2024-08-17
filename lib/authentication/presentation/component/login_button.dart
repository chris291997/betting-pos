import 'dart:convert';

import 'package:bet_pos/authentication/presentation/viewmodel/auth_viewmodel.dart';
import 'package:bet_pos/bet/presentation/screen/select_to_bet_screen.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/di/service_locator.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/dashboard/presentation/screen/pos_dashboard.dart';
import 'package:bet_pos/user/data/di/user_service_locator.dart';
import 'package:bet_pos/user/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// TODO: Refactor auth viewmodel and account bloc combination.
// TEMP: This is a temporary solution to combine auth viewmodel and account bloc to reduce coding time.
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthViewmodel, AuthState>(
          listener: (context, state) async {
            if (state.status.isSuccess) {
              final accountBloc = context.read<AccountBloc>();

              final user = await cacheService.read(StorageKey.loggedUser);

              print('user: $user');

              final userOutput = UserOutput.fromJson(jsonDecode(user ?? ''));
              print('userOutput: $userOutput');

              accountBloc.add(AccountEventUserSet(userOutput));

              // ignore: use_build_context_synchronously
              context.go(PosDashboard.routeName);
            } else if (state.status.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login failed',
                    style: context.textStyle.caption.copyWith(
                      color: context.colors.onError,
                    ),
                  ),
                  backgroundColor: context.colors.error,
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthViewmodel, AuthState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, authState) {
          return PrimaryButton(
            labelText: 'Login',
            state: authState.status.isLoading
                ? PrimaryButtonState.loading
                : PrimaryButtonState.enabled,
            onPressed: () {
              // context.go(EventScreen.routeName);
              context.read<AuthViewmodel>().add(AuthLoginRequested());
            },
          );
        },
      ),
    );
  }
}
