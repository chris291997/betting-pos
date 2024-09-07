// ignore_for_file: use_build_context_synchronously
import 'package:bet_pos/bet/presentation/bloc/bet_details_bloc.dart';
import 'package:bet_pos/bet/presentation/component/bet_screen_wrapper.dart';
import 'package:bet_pos/bet/presentation/screen/claim_bet_screen.dart';
import 'package:bet_pos/common/hook/use_mobile_scanner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerScreen extends HookWidget {
  const QrCodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMobileScannerController(
      formats: const [BarcodeFormat.qrCode],
    );

    return BetScreenWrapper(
      appBarTitle: 'Scan QR Code',
      contentVerticalAlignment: MainAxisAlignment.center,
      content: [
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: Stack(
              children: [
                MobileScanner(
                  fit: BoxFit.cover,
                  controller: controller,
                  onDetect: (barcodes) async {
                    final barcode = barcodes.barcodes.firstOrNull;

                    if (barcode != null) {
                      if ((barcode.rawValue ?? '').isEmpty) return;

                      final transactionId = barcode.rawValue;

                      await controller.stop();

                      context.read<BetDetailsBloc>().add(
                            BetDetailsFetchedByTransactionId(
                                transactionId ?? ''),
                          );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (routeContext) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<BetDetailsBloc>(),
                              ),
                            ],
                            child: const ClaimBetScreen(
                              entryPoint: ClaimBetEntryPoint.scanned,
                            ),
                          );
                        }),
                      ).then((value) async {
                        await controller.start();
                      });
                    }
                  },
                  errorBuilder: (context, error, widget) {
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        })
      ],
      nextButtons: const [],
    );
  }
}
