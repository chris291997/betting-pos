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
    // final buttonState = useState(PrimaryButtonState.enabled);

    return BetNextStepButton(
      label: 'Use Thermal Printer',
      // state: buttonState.value,
      onPressed: () {
        // buttonState.value = PrimaryButtonState.loading;

        // await ReceiptPrinterService.of(context, betOutput.toReceiptDetails())
        //     .printReceiptUsingThermalPrinter()
        //     .then((_) {
        //   buttonState.value = PrimaryButtonState.enabled;
        // }).onError((_, __) {
        //   buttonState.value = PrimaryButtonState.enabled;
        // });
        ReceiptPrinterService.of(context, betOutput.toReceiptDetails())
            .printReceiptUsingThermalPrinter();
      },
    );
  }
}
