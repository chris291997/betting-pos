import 'package:bet_pos/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';

class BetFormField extends StatelessWidget {
  const BetFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Bet'),
        const SizedBox(
          height: 10,
        ),
        BaseTextfield(
          onChanged: (_) {},
          labelText: 'Place Your Bet',
        ),
      ],
    );
  }
}
