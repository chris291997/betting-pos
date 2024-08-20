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

    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 300,
      height: 300,
    );

    return BetScreenWrapper(
      appBarTitle: 'Scan QR Code',
      contentVerticalAlignment: MainAxisAlignment.center,
      content: [
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: controller,
              scanWindow: scanWindow,
              onDetect: (barcodes) async {
                final barcode = barcodes.barcodes.firstOrNull;
                if (barcode != null) {
                  if ((barcode.rawValue ?? '').isEmpty) return;

                  final transactionId = barcode.rawValue;

                  await controller.stop();

                  context.read<BetDetailsBloc>().add(
                        BetDetailsFetchedByTransactionId(transactionId ?? ''),
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
                  );
                }
              },
              overlayBuilder: (context, widget) {
                return CustomPaint(
                  painter: _ScannerOverlay(scanWindow: scanWindow),
                );
              },
              errorBuilder: (context, error, widget) {
                print('Error: $error');
                print('ErrorCode: ${error.errorCode}');
                print('Error: ${error.errorDetails?.message}');
                return Center(
                  child: Text(
                    error.toString(),
                  ),
                );
              },
            ),
          );
        })
      ],
      nextButtons: const [],
    );
  }
}

// class LifecycleObserver extends WidgetsBindingObserver {
//   final MobileScannerController controller;
//   final ValueNotifier<StreamSubscription<Object?>?> subscription;

//   LifecycleObserver(this.controller, this.subscription);

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!controller.value.isInitialized) {
//       return;
//     }

//     switch (state) {
//       case AppLifecycleState.resumed:
//         subscription.value = controller.barcodes.listen((barcode) {
//           print('Barcode detected: $barcode');
//         });
//         controller.start();
//         break;
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.paused:
//         subscription.value?.cancel();
//         subscription.value = null;
//         controller.stop();
//         break;
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//         break;
//     }
//   }
// }

// class QrCodeScannerScreen extends HookWidget {
//   const QrCodeScannerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = useMobileScannerController(
//       formats: const [BarcodeFormat.qrCode],
//     );

//     useEffect(
//       () {
//         controller.stop();
//         return controller.stop;
//       },
//       [],
//     );
//     // final scanWindow = Rect.fromCenter(
//     //   center: MediaQuery.sizeOf(context).center(Offset.zero),
//     //   width: 300,
//     //   height: 300,
//     // );

//     return BetScreenWrapper(
//       appBarTitle: 'Scan QR Code',
//       contentVerticalAlignment: MainAxisAlignment.center,
//       content: [
//         Container(
//           width: 300,
//           height: 300,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.blueAccent,
//               width: 4.0,
//             ),
//             borderRadius:
//                 BorderRadius.circular(12.0), // Optional: add rounded corners
//           ),
//           child: MobileScanner(
//               fit: BoxFit.fill,
//               controller: controller,
//               // scanWindow: scanWindow,
//               onDetect: (barcodes) {
//                 print('Barcodes: ${barcodes.image}');
//                 Navigator.pop(context, null);
//               },
//               errorBuilder: (context, error, widget) {
//                 print('Error: $error');
//                 print('ErrorCode: ${error.errorCode}');
//                 print('Error: ${error.errorDetails?.message}');
//                 return Center(
//                   child: Text(
//                     error.toString(),
//                   ),
//                 );
//               }),
//         )
//       ],
//       nextButtons: const [],
//     );
//   }
// }

class _ScannerOverlay extends CustomPainter {
  const _ScannerOverlay({
    required this.scanWindow,
    // ignore: unused_element
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: use `Offset.zero & size` instead of Rect.largest
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(_ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
