import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
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
            const Text('Bet Payment Details'),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Bet'),
                Text(amount.toString()),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Others'),
                Text('0'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total'),
                Text(amount.toString()),
              ],
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
