import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/select_bet_card_v2.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:bet_pos/fighter/data/di/fighter_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiptDetailsView extends StatelessWidget {
  const ReceiptDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TransactionId(),
        _BetOnCard(),
        BetDetails(),
      ],
    );
  }
}

class BetDetails extends StatelessWidget {
  const BetDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetDetailsBloc, BetDetailsState>(
      builder: (context, state) {
        final betOutput = state.betOutput;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 30,
            ),
            Text('Bet Details', style: context.textStyle.subtitle1),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bet Amount', style: context.textStyle.subtitle2),
                Text(
                  betOutput.betAmount.toString(),
                  style: context.textStyle.subtitle2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fight Number', style: context.textStyle.subtitle2),
                Text(
                  betOutput.fight.fightNumber.toString(),
                  style: context.textStyle.subtitle2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Time', style: context.textStyle.subtitle2),
                Text(
                  betOutput.fight.startTime,
                  style: context.textStyle.subtitle2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event',
                  style: context.textStyle.subtitle2,
                ),
                Text(
                  betOutput.event.eventName,
                  style: context.textStyle.subtitle2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Event Date', style: context.textStyle.subtitle2),
                if (betOutput.event.eventDate != null)
                  Text(
                    DateFormat('yyyy-MM-dd')
                        .format(
                          betOutput.event.eventDate ?? DateTime.now(),
                        )
                        .toString(),
                    style: context.textStyle.subtitle2,
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: context.layout.largeSpacing),
              child: Row(
                mainAxisAlignment: betOutput.winnings > 0
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (betOutput.winnings > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Winnings',
                          style: context.textStyle.headline6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          betOutput.winnings.toStringAsFixed(2),
                          style: context.textStyle.headline5,
                        ),
                      ],
                    ),
                  const _QrCodeDisplay(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      },
    );
  }
}

class _BetOnCard extends StatelessWidget {
  const _BetOnCard();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetDetailsBloc, BetDetailsState, BetOutput>(
      selector: (state) {
        return state.betOutput;
      },
      builder: (context, betOutput) {
        final fighterOutput = betOutput.betOn;
        final fighterType = fighterOutput.id == betOutput.fight.walaId
            ? FighterType.wala
            : FighterType.meron;

        return SelectBetCardV2(
          fighterType: fighterType,
          isSelected: false,
          onTap: () {},
        );
      },
    );
  }
}

class _TransactionId extends StatelessWidget {
  const _TransactionId();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetDetailsBloc, BetDetailsState, String>(
      selector: (state) {
        return state.betOutput.transactionId;
      },
      builder: (context, transactionId) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Transaction ID',
              style: context.textStyle.subtitle2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              transactionId,
              style: context.textStyle.subtitle1,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        );
      },
    );
  }
}

class _QrCodeDisplay extends StatelessWidget {
  const _QrCodeDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetDetailsBloc, BetDetailsState>(
      builder: (context, state) {
        final qrToken = state.betOutput.transactionId;

        return Center(
          child: QrImageView(
            data: qrToken,
            version: QrVersions.auto,
            size: 100.0,
          ),
        );
      },
    );
  }
}
