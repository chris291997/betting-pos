import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:printing/printing.dart';

class ReceiptPrinterService {
  static ReceiptPrinterService? _instance;
  final BuildContext context;
  final ReceiptDetails receiptDetails;

  ReceiptPrinterService._(this.context, this.receiptDetails);

  static ReceiptPrinterService of(BuildContext context, ReceiptDetails receiptDetails) {
    _instance ??= ReceiptPrinterService._(context, receiptDetails);
    return _instance!;
  }

  Future<List<int>> generateThermalPrinterReadyReceipt() async {
    try{
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // Add top padding
    bytes += generator.feed(4);

    // Add header
    bytes += generator.text(
      'Official Receipt',
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += generator.feed(2);

    // Add receipt details
    bytes += generator.text('Transaction ID: ${receiptDetails.transactionId}');
    bytes += generator.feed(1);
    bytes += generator.text('Event Name: ${receiptDetails.eventName}');
    bytes += generator.feed(1);
    bytes += generator.text('Event Date: ${receiptDetails.eventDate?.toString()}');
    bytes += generator.feed(1);
    bytes += generator.text('Location: ${receiptDetails.location}');
    bytes += generator.feed(1);
    bytes += generator.text('Fight Number: ${receiptDetails.fightNumber.toString()}');
    bytes += generator.feed(1);
    bytes += generator.text('Bet On: ${receiptDetails.betOnName}');
    bytes += generator.feed(1);
    bytes += generator.text('Bet Amount: P${receiptDetails.betAmount.toString()}');
    bytes += generator.feed(1);
    bytes += generator.text('POS Number: ${receiptDetails.posNumber}');
    bytes += generator.feed(1);
    bytes += generator.text('Cashier: ${receiptDetails.userName}');
    bytes += generator.feed(1);
    bytes += generator.text('Created At: ${receiptDetails.createdAt}');
    bytes += generator.feed(2);

    // Print QR code
    bytes += generator.qrcode(receiptDetails.transactionId);

    // Add bottom padding
    bytes += generator.feed(4);

    bytes += generator.cut();
    return bytes;
    }catch(e){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      }

      return [];
    }
  }

  Future<Uint8List> generatePdfPreview() async {
    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/roboto/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
        build: (pw.Context context) {
          return pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Official Receipt',
                  style: pw.TextStyle(
                      font: ttf, fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Transaction ID: ${receiptDetails.transactionId}',
                  style: pw.TextStyle(font: ttf),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Event Name: ${receiptDetails.eventName}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Event Date: ${receiptDetails.eventDate}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Location: ${receiptDetails.location}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Fight Number: ${receiptDetails.fightNumber}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Bet On: ${receiptDetails.betOnName}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Bet Amount: ₱${receiptDetails.betAmount}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'POS Number: ${receiptDetails.posNumber}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Cashier: ${receiptDetails.userName}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Created At: ${receiptDetails.createdAt}',
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                ),
                pw.SizedBox(height: 20),
                pw.BarcodeWidget(
                  data: receiptDetails.transactionId,
                  barcode: pw.Barcode.qrCode(),
                  width: 200,
                  height: 80,
                ),
              ],
            ),
          );
        },
      ),
    );

     return pdf.save();
  }

  Future<void> downloadPdf(Uint8List pdfData) async {
    await Printing.sharePdf(bytes: pdfData, filename: 'receipt_preview.pdf');
  }

  Future<void> _bluetoothPermissionHandler() async{
    final bool result = await PrintBluetoothThermal.isPermissionBluetoothGranted;
    if(!result){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable bluetooth permission'),
        ),
      );
      }
    }
  }


  Future<void> _bluetoothEnabledHandler() async{
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if(!result){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable bluetooth'),
        ),
      );
      }
    }
  }

  Future<void> printReceiptUsingThermalPrinter()async {
    await _bluetoothPermissionHandler();
    await _bluetoothEnabledHandler();
    try{
       final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;
    
    if(listResult.isEmpty) return;
  if(context.mounted){

    final deviceNames = listResult.map((e) => e.name).join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(deviceNames),
        ),
      );
  }


     await PrintBluetoothThermal.connect(macPrinterAddress: listResult.first.macAdress);

     bool conectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (conectionStatus) {

      List<int> ticket = await generateThermalPrinterReadyReceipt();
       await PrintBluetoothThermal.writeBytes(ticket);
    } 
    }catch(e){
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      }
    }
  

  }



}

class ReceiptDetails extends Equatable {
  const ReceiptDetails({
    required this.betAmount,
    required this.transactionId,
    required this.qrToken,
    required this.eventName,
    required this.eventDate,
    required this.location,
    required this.fightNumber,
    required this.betOnName,
    required this.posNumber,
    required this.userName,
    required this.createdAt,
  });

  final double betAmount;
  final String transactionId;
  final String qrToken;
  final String eventName;
  final String? eventDate;
  final String location;
  final int fightNumber;
  final String betOnName;
  final String posNumber;
  final String userName;
  final String createdAt;

  ReceiptDetails copyWith({
    double? betAmount,
    String? transactionId,
    String? qrToken,
    String? eventName,
    String? eventDate,
    String? location,
    int? fightNumber,
    String? betOnName,
    String? posNumber,
    String? userName,
    String? createdAt,
  }) {
    return ReceiptDetails(
      betAmount: betAmount ?? this.betAmount,
      transactionId: transactionId ?? this.transactionId,
      qrToken: qrToken ?? this.qrToken,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      location: location ?? this.location,
      fightNumber: fightNumber ?? this.fightNumber,
      betOnName: betOnName ?? this.betOnName,
      posNumber: posNumber ?? this.posNumber,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        betAmount,
        transactionId,
        qrToken,
        eventName,
        eventDate,
        location,
        fightNumber,
        betOnName,
        posNumber,
        userName,
        createdAt,
      ];
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

  // Future<Uint8List> generatePdfPreview(
  //     {required ReceiptDetails receiptDetails}) async {
  //   final pdf = pw.Document();

  //   final fontData =
  //       await rootBundle.load('assets/fonts/roboto/Roboto-Regular.ttf');
  //   final ttf = pw.Font.ttf(fontData);

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text(
  //               'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ',
  //               style: pw.TextStyle(font: ttf),
  //             ),
  //             pw.Text(
  //               'Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //               style: pw.TextStyle(font: ttf, fontSize: 12),
  //             ),
  //             pw.Text(
  //               'Special 2: blåbærgrød',
  //               style: pw.TextStyle(font: ttf, fontSize: 12),
  //             ),
  //             pw.Text(
  //               'Bold text',
  //               style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
  //             ),
  //             pw.Text(
  //               'Reverse text',
  //               style: pw.TextStyle(
  //                 font: ttf,
  //                 background: const pw.BoxDecoration(color: PdfColors.black),
  //               ),
  //             ),
  //             pw.Text(
  //               'Underlined text',
  //               style: pw.TextStyle(
  //                 font: ttf,
  //                 decoration: pw.TextDecoration.underline,
  //               ),
  //             ),
  //             pw.Text(
  //               'Align left',
  //               style: pw.TextStyle(font: ttf),
  //               textAlign: pw.TextAlign.left,
  //             ),
  //             pw.Text(
  //               'Align center',
  //               style: pw.TextStyle(font: ttf),
  //               textAlign: pw.TextAlign.center,
  //             ),
  //             pw.Text(
  //               'Align right',
  //               style: pw.TextStyle(font: ttf),
  //               textAlign: pw.TextAlign.right,
  //             ),
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Text('col3',
  //                     style: pw.TextStyle(font: ttf),
  //                     textAlign: pw.TextAlign.center),
  //                 pw.Text('col6',
  //                     style: pw.TextStyle(font: ttf),
  //                     textAlign: pw.TextAlign.center),
  //                 pw.Text('col3',
  //                     style: pw.TextStyle(font: ttf),
  //                     textAlign: pw.TextAlign.center),
  //               ],
  //             ),
  //             pw.Text(
  //               'Text size 200%',
  //               style: pw.TextStyle(font: ttf, fontSize: 24),
  //             ),
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




  // Future<List<int>> generateSampleReceipt() async {
  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm80, profile);
  //   List<int> bytes = [];

  //   bytes += generator.text(
  //       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //       styles: const PosStyles(codeTable: 'CP1252'));
  //   bytes += generator.text('Special 2: blåbærgrød',
  //       styles: const PosStyles(codeTable: 'CP1252'));

  //   bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  //   bytes +=
  //       generator.text('Reverse text', styles: const PosStyles(reverse: true));
  //   bytes += generator.text('Underlined text',
  //       styles: const PosStyles(underline: true), linesAfter: 1);
  //   bytes += generator.text('Align left',
  //       styles: const PosStyles(align: PosAlign.left));
  //   bytes += generator.text('Align center',
  //       styles: const PosStyles(align: PosAlign.center));
  //   bytes += generator.text('Align right',
  //       styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

  //   bytes += generator.row([
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col6',
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'col3',
  //       width: 3,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //   ]);

  //   bytes += generator.text('Text size 200%',
  //       styles: const PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ));

  //   // Print barcode
  //   final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  //   bytes += generator.barcode(Barcode.upcA(barData));

  //   bytes += generator.feed(2);
  //   bytes += generator.cut();
  //   return bytes;
  // }


  // Future<Uint8List> generatePdfPreview(
  //     {required ReceiptDetails receiptDetails}) async {
  //   final pdf = pw.Document();

  //   final fontData =
  //       await rootBundle.load('assets/fonts/roboto/Roboto-Regular.ttf');
  //   final ttf = pw.Font.ttf(fontData);
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
  //       build: (pw.Context context) {
  //         return pw.Padding(
  //           padding:
  //               const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 40),
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               pw.Text(
  //                 'Transaction ID: ${receiptDetails.transactionId}',
  //                 style: pw.TextStyle(font: ttf),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Event Name: ${receiptDetails.eventName}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Event Date: ${receiptDetails.eventDate}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Location: ${receiptDetails.location}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Fight Number: ${receiptDetails.fightNumber}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Bet On: ${receiptDetails.betOnName}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Bet Amount: \$${receiptDetails.betAmount}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'POS Number: ${receiptDetails.posNumber}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'User Name: ${receiptDetails.userName}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Created At: ${receiptDetails.createdAt}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 12),
  //               ),
  //               pw.SizedBox(height: 20),
  //               pw.BarcodeWidget(
  //                 data: receiptDetails.transactionId,
  //                 barcode: pw.Barcode.qrCode(),
  //                 width: 200,
  //                 height: 80,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }