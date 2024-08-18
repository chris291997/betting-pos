import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptPrinterService {
  ReceiptPrinterService();

  Future<List<int>> generateSampleReceipt() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød',
        styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  // Future<Uint8List> generatePdfPreview() async {
  //   final pdf = pw.Document();

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(
  //                 'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ'),
  //             pw.Text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //                 style: pw.TextStyle(font: pw.Font.courier(), fontSize: 12)),
  //             pw.Text('Special 2: blåbærgrød',
  //                 style: pw.TextStyle(font: pw.Font.courier(), fontSize: 12)),
  //             pw.Text('Bold text',
  //                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //             pw.Text('Reverse text',
  //                 style: const pw.TextStyle(
  //                     background: pw.BoxDecoration(color: PdfColors.black))),
  //             pw.Text('Underlined text',
  //                 style: const pw.TextStyle(
  //                     decoration: pw.TextDecoration.underline)),
  //             pw.Text('Align left', textAlign: pw.TextAlign.left),
  //             pw.Text('Align center', textAlign: pw.TextAlign.center),
  //             pw.Text('Align right', textAlign: pw.TextAlign.right),
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Text('col3', textAlign: pw.TextAlign.center),
  //                 pw.Text('col6', textAlign: pw.TextAlign.center),
  //                 pw.Text('col3', textAlign: pw.TextAlign.center),
  //               ],
  //             ),
  //             pw.Text('Text size 200%',
  //                 style: const pw.TextStyle(fontSize: 24)),
  //             pw.BarcodeWidget(
  //               data: '12345678904',
  //               barcode: pw.Barcode.upcA(),
  //               width: 200,
  //               height: 80,
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }

  Future<Uint8List> generatePdfPreview() async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assets/fonts/roboto/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ',
                style: pw.TextStyle(font: ttf),
              ),
              pw.Text(
                'Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
                style: pw.TextStyle(font: ttf, fontSize: 12),
              ),
              pw.Text(
                'Special 2: blåbærgrød',
                style: pw.TextStyle(font: ttf, fontSize: 12),
              ),
              pw.Text(
                'Bold text',
                style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Reverse text',
                style: pw.TextStyle(
                  font: ttf,
                  background: pw.BoxDecoration(color: PdfColors.black),
                ),
              ),
              pw.Text(
                'Underlined text',
                style: pw.TextStyle(
                  font: ttf,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.Text(
                'Align left',
                style: pw.TextStyle(font: ttf),
                textAlign: pw.TextAlign.left,
              ),
              pw.Text(
                'Align center',
                style: pw.TextStyle(font: ttf),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                'Align right',
                style: pw.TextStyle(font: ttf),
                textAlign: pw.TextAlign.right,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('col3',
                      style: pw.TextStyle(font: ttf),
                      textAlign: pw.TextAlign.center),
                  pw.Text('col6',
                      style: pw.TextStyle(font: ttf),
                      textAlign: pw.TextAlign.center),
                  pw.Text('col3',
                      style: pw.TextStyle(font: ttf),
                      textAlign: pw.TextAlign.center),
                ],
              ),
              pw.Text(
                'Text size 200%',
                style: pw.TextStyle(font: ttf, fontSize: 24),
              ),
              pw.BarcodeWidget(
                data: '12345678904',
                barcode: pw.Barcode.upcA(),
                width: 200,
                height: 80,
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> downloadPdf(Uint8List pdfData) async {
    await Printing.sharePdf(bytes: pdfData, filename: 'receipt_preview.pdf');
  }
}
