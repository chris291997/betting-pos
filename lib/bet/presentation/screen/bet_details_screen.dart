import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/common/component/textfield/primary_search_bar.dart';
import 'package:bet_pos/common/theme/theme.dart';
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
          final receiptDetails = state.betOutput.toReceiptDetails();
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
                _BetDetailItem(
                  label: 'Transaction ID',
                  value: receiptDetails.transactionId,
                ),
                _BetDetailItem(
                  label: 'Event Name',
                  value: receiptDetails.eventName,
                ),
                _BetDetailItem(
                  label: 'Event Date',
                  value: receiptDetails.eventDate ?? '',
                ),
                _BetDetailItem(
                  label: 'Location',
                  value: receiptDetails.location,
                ),
                _BetDetailItem(
                  label: 'Fight Number',
                  value: receiptDetails.fightNumber.toString(),
                ),
                _BetDetailItem(
                  label: 'Bet On',
                  value: receiptDetails.betOnName,
                ),
                _BetDetailItem(
                  label: 'Bet Amount',
                  value: '₱${receiptDetails.betAmount}',
                ),
                _BetDetailItem(
                  label: 'POS Number',
                  value: receiptDetails.posNumber,
                ),
                _BetDetailItem(
                  label: 'User Name',
                  value: receiptDetails.userName,
                ),
                _BetDetailItem(
                  label: 'Created At',
                  value: receiptDetails.createdAt,
                )
              ] else ...[
                const Center(
                  child: Text('No Transaction Requested'),
                ),
              ]
            ],
            nextButtons: [
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

class _BetDetailItem extends StatelessWidget {
  const _BetDetailItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: context.textStyle.subtitle1,
          ),
          Expanded(
            child: Text(value, style: context.textStyle.subtitle2),
          ),
        ],
      ),
    );
  }
}
