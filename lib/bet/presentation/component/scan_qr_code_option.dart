import 'package:bet_pos/bet/presentation/screen/qr_code_scanner_screen.dart';
import 'package:bet_pos/common/component/card/base_card.dart';
import 'package:bet_pos/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScanQrCodeOption extends StatelessWidget {
  const ScanQrCodeOption({super.key});

  static const _qrCodeLogo = 'assets/svg/qr-code-logo.svg';

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QrCodeScannerScreen()),
        );

        // Use the result
        if (result != null) {
          print('Result: $result');
        }
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _qrCodeLogo,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Scan QR Code', style: context.textStyle.subtitle2),
        ],
      ),
    );
  }
}
