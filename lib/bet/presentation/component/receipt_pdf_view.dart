import 'package:bet_pos/bet/data/di/bet_service_locator.dart';
import 'package:bet_pos/common/service/receipt_printer_service.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReceiptPdfView extends StatelessWidget {
  const ReceiptPdfView({
    super.key,
    required this.betOutput,
  });

  final BetOutput betOutput;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: PdfPreview(
        pdfFileName: 'receipt.pdf',
        build: (format) => ReceiptPrinterService()
            .generatePdfPreview(receiptDetails: betOutput.toReceiptDetails()),
        canDebug: false,
        dynamicLayout: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
      ),
    );
  }
}
