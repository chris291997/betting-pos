import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_amount_form_field_v2.dart';
import 'package:bet_pos/bet/presentation/component/bet_continue_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_fighters_v2.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/event_details.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/event/data/di/event_service_locator.dart';
import 'package:bet_pos/event/presentation/bloc/current_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectToBetScreenV2 extends StatelessWidget {
  const SelectToBetScreenV2({super.key});

  static const routeName = '/bet';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BetBloc(betRepository),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CurrentEventBloc(eventRepository)
            ..add(
              const CurrentEventRequested(),
            ),
        ),
      ],
      child: BlocBuilder<CurrentEventBloc, CurrentEventState>(
        builder: (context, state) {
          final status = state.status;
          if (status.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (status.isSuccess || status.isError) {
            return BetScreenWrapper(
              appBarTitle: 'Place Your Bet',
              contentVerticalAlignment: status.isError
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              content: status.isError
                  ? [
                      Center(
                          child:
                              Text(state.errorMessage ?? 'An error occurred')),
                    ]
                  : [
                      const SizedBox(height: 20),
                      Text('Bet Details', style: context.textStyle.headline5),
                      const SizedBox(height: 30),
                      const EventDetails(),
                      const SizedBox(height: 20),
                      const BetFightersV2(),
                      const SizedBox(height: 20),
                      const BetAmountFormFieldV2(),
                      const SizedBox(height: 20),
                    ],
              nextButtons: const [BetContinueButton()],
              onAppbarBackButtonPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            );
          }

          return const Scaffold(
            body: SizedBox(),
          );
        },
      ),
    );
  }
}
