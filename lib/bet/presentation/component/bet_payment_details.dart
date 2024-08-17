import 'package:flutter/material.dart';

class BetPaymentDetails extends StatelessWidget {
  const BetPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Bet Payment Details'),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bet'),
            Text('1000'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Others'),
            Text('0'),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
