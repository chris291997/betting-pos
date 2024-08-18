import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/receipt_details_view.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/component/textfield/primary_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BetDetailsScreen extends StatelessWidget {
  const BetDetailsScreen({super.key});

  static const routeName = '/bet-details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BetDetailsBloc(betRepository),
      child: BlocBuilder<BetDetailsBloc, BetDetailsState>(
        builder: (context, state) {
          final status = state.status;

          return BetScreenWrapper(
            appBarTitle: 'Transaction Details',
            contentVerticalAlignment: status.isSuccess
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            content: [
              if (status.isLoading) ...[
                const Center(
                  child: CircularProgressIndicator(),
                )
              ] else if (status.isError) ...[
                const Center(
                  child: Text('No Transaction Found'),
                )
              ] else if (status.isSuccess) ...[
                const ReceiptDetailsView(),
              ] else ...[
                const Center(
                  child: Text('No Transaction Requested'),
                ),
              ]
            ],
            nextButtons: [
              if (status.isSuccess && state.betOutput.isNotEmpty) ...[
                BetNextStepButton(
                  label: 'Claim',
                  onPressed: () {},
                  state: PrimaryButtonState.disabled,
                ),
              ],
              const SizedBox(height: 20),
              PrimarySearchBar(
                hintText: 'Enter Transaction ID',
                onSearch: (id) {
                  context.read<BetDetailsBloc>().add(
                        BetDetailsFetchedByTransactionId(id),
                      );
                },
              ),
            ],
            onAppbarBackButtonPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          );
        },
      ),
    );
  }
}
