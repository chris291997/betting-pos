import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/screen/confirm_bet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BetContinueButton extends StatelessWidget {
  const BetContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetBloc, BetState, bool>(
      selector: (state) {
        return state.input.hasEmptyAttribute;
      },
      builder: (context, hasEmptyAttribute) {
        return BetNextStepButton(
          label: 'Continue',
          onPressed: () {
            if (hasEmptyAttribute) {
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (routeContext) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: context.read<BetBloc>(),
                      ),
                    ],
                    child: const ConfirmBetScreen(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
