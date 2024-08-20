import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/receipt_details_view.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClaimBetScreen extends StatelessWidget {
  const ClaimBetScreen({
    super.key,
    required this.entryPoint,
  });

  final ClaimBetEntryPoint entryPoint;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetDetailsBloc, BetDetailsState>(
      builder: (context, state) {
        final status = state.status;

        return BetScreenWrapper(
          appBarTitle: 'Claim Bet',
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
          ],
          onAppbarBackButtonPressed: () {
            if (entryPoint.isSearched) {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}

enum ClaimBetEntryPoint {
  scanned,
  searched;

  bool get isScanned => this == ClaimBetEntryPoint.scanned;
  bool get isSearched => this == ClaimBetEntryPoint.searched;
}
