import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment'),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.lightGreen,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.money,
                color: Colors.lightGreen,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.layout.mediumPadding),
                child: const Text('Cash'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
