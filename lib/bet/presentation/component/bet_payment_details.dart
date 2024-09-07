import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BetPaymentDetails extends StatelessWidget {
  const BetPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BetBloc, BetState, double>(
      selector: (state) {
        return state.input.betAmount;
      },
      builder: (context, amount) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bet Payment Details', style: context.textStyle.subtitle1),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bet', style: context.textStyle.subtitle2),
                Text(
                  amount.toString(),
                  style: context.textStyle.subtitle2,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
