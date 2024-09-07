import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/bloc/claim_bet_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/component/receipt_details_view.dart';
import 'package:bet_pos/common/component/button/primary_button.dart';
import 'package:bet_pos/common/service/receipt_printer_service.dart';
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
    return BlocProvider(
      lazy: false,
      create: (context) => ClaimBetBloc(betRepository),
      child: _ClaimBetScreen(
        entryPoint: entryPoint,
      ),
    );
  }
}

class _ClaimBetScreen extends StatelessWidget {
  const _ClaimBetScreen({
    required this.entryPoint,
  });

  final ClaimBetEntryPoint entryPoint;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClaimBetBloc, ClaimBetState>(
      listener: (listenerContext, state) {
        if (state.status.isSuccess && state.betOutput.isNotEmpty) {
          context.read<BetDetailsBloc>().add(
                BetDetailsInitial(),
              );

          context.read<BetDetailsBloc>().add(
                BetDetailsFetchedByTransactionId(
                  state.betOutput.transactionId,
                ),
              );

          context.read<ClaimBetBloc>().add(
                const ClaimBetInitialized(),
              );

          ReceiptPrinterService.of(context, state.betOutput.toReceiptDetails())
              .printReceiptUsingThermalPrinter();

          Navigator.pop(context);
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to Claim Bet'),
            ),
          );
        }
      },
      builder: (context, claimState) {
        return BlocBuilder<BetDetailsBloc, BetDetailsState>(
          builder: (context, state) {
            final status = state.status;
            final betOutput = state.betOutput;
            final buttonState = betOutput.isClaimable
                ? PrimaryButtonState.enabled
                : PrimaryButtonState.disabled;

            return BetScreenWrapper(
              canPop: !status.isSuccess,
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
                    label: 'Claim${betOutput.isClaimed ? 'ed' : ''}',
                    onPressed: () {
                      context.read<ClaimBetBloc>().add(
                            ClaimBetSubmitted(
                              transactionId: betOutput.transactionId,
                            ),
                          );
                    },
                    state: claimState.status.isLoading
                        ? PrimaryButtonState.loading
                        : buttonState,
                  ),
                ],
              ],
              onAppbarBackButtonPressed: () {
                Navigator.pop(context);
                // if (entryPoint.isSearched) {
                //   Navigator.pop(context);
                // } else {
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                // }
              },
            );
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
