import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:flutter/material.dart';

class PrintReceiptButton extends StatelessWidget {
  const PrintReceiptButton({
    super.key,
    required this.betOutput,
  });
  final BetOutput betOutput;

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Use Thermal Printer',
      onPressed: () async {
        // print('Start printing receipt');
        // await ReceiptPrinterService()
        //     .printReceiptUsingThermalPrinter(betOutput.toReceiptDetails());
        // print('End printing receipt');
      },
    );
  }
}
