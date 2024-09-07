import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/bet/presentation/component/bet_next_step_button.dart';
import 'package:bet_pos/common/service/receipt_printer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PrintReceiptButton extends HookWidget {
  const PrintReceiptButton({
    super.key,
    required this.betOutput,
  });
  final BetOutput betOutput;

  @override
  Widget build(BuildContext context) {
    return BetNextStepButton(
      label: 'Use Thermal Printer',
      // state: buttonState.value,
      onPressed: () {
        ReceiptPrinterService.of(context, betOutput.toReceiptDetails())
            .printReceiptUsingThermalPrinter();
      },
    );
  }
}
