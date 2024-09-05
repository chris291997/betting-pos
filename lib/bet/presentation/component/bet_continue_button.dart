import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/screen/confirm_bet_screen.dart';
import 'package:bet_pos/event/presentation/bloc/current_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BetContinueButton extends StatelessWidget {
  const BetContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Continue',
      onPressed: () {
        final state = context.read<BetBloc>().state;
        if (state.input.hasEmptyAttribute) {
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
                  BlocProvider.value(value: context.read<CurrentEventBloc>()),
                ],
                child: const ConfirmBetScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
