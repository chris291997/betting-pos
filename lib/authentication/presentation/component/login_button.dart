import 'package:bet_pos/authentication/presentation/viewmodel/auth_viewmodel.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/theme/theme.dart';
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
          listener: (context, state) {
            if (state.status.isSuccess) {
              context
                  .read<AccountBloc>()
                  .add(AccountEventLoggedUserRequested());
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
              // context.go(EventScreen.routeName);
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listenWhen: (previous, current) =>
              previous.userOutput != current.userOutput,
          listener: (context, state) {
            if (state.userOutput.isNotEmpty) {
              // context.go(EventScreen.routeName);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthViewmodel, AuthState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, authState) {
          return BlocBuilder<AccountBloc, AccountState>(
            builder: (context, accountState) {
              return PrimaryButton(
                labelText: 'Login',
                state:
                    accountState.status.isLoading || authState.status.isLoading
                        ? PrimaryButtonState.loading
                        : PrimaryButtonState.enabled,
                onPressed: () {
                  // context.go(EventScreen.routeName);
                  context.read<AuthViewmodel>().add(AuthLoginRequested());
                },
              );
            },
          );
        },
      ),
    );
  }
}
