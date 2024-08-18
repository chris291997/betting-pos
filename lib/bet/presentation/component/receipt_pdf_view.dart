import 'package:bet_pos/common/service/receipt_printer_service.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReceiptPdfView extends StatelessWidget {
  const ReceiptPdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: PdfPreview(
        pdfFileName: 'receipt.pdf',
        build: (format) => ReceiptPrinterService().generatePdfPreview(),
        canDebug: false,
        dynamicLayout: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
      ),
    );
  }
}
