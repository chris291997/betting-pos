import 'package:bet_pos/bet/presentation/bloc/bet_bloc.dart';
import 'package:bet_pos/common/component/textfield/base_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onChanged: (value) {
            final amount = double.tryParse(value);
            if (amount != null) {
              context.read<BetBloc>().add(
                    BetAmountAdded(amount),
                  );
            }
          },
          labelText: 'Place Your Bet',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }
}
