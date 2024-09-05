import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:printing/printing.dart';

class ReceiptPrinterService {
  final BuildContext context;
  final ReceiptDetails receiptDetails;

  ReceiptPrinterService._(this.context, this.receiptDetails);

  static ReceiptPrinterService of(
      BuildContext context, ReceiptDetails receiptDetails) {
    return ReceiptPrinterService._(context, receiptDetails);
  }

  Future<List<int>> generateThermalPrinterReadyReceipt() async {
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      final isClaimedReceipt = receiptDetails.claimedBy.isNotEmpty;
      List<int> bytes = [];

      // Add top padding
      bytes += generator.feed(1);

      // Add header
      // final header = receiptDetails.claimedBy.isEmpty
      //     ? 'Official Receipt'
      //     : 'Claimed Receipt';
      // bytes += generator.text(
      //   header,
      //   styles: const PosStyles(
      //     align: PosAlign.center,
      //     height: PosTextSize.size2,
      //     width: PosTextSize.size2,
      //     bold: true,
      //   ),
      // );
      // bytes += generator.feed(2);

      // Add receipt details
      // bytes +=
      //     generator.text('Transaction ID: ${receiptDetails.transactionId}');
      // // bytes += generator.text('Event Name: ${receiptDetails.eventName}');
      // // bytes +=
      // //     generator.text('Event Date: ${receiptDetails.eventDate?.toString()}');
      // // bytes += generator.text('Location: ${receiptDetails.location}');

      // if (receiptDetails.claimedBy.isNotEmpty) {
      //   bytes += generator.text('Claimed By: ${receiptDetails.claimedBy}');
      //   bytes += generator.text('Claimed At: ${receiptDetails.claimedAt}');
      // }
      // bytes += generator
      //     .text('Fight Number: ${receiptDetails.fightNumber.toString()}');
      // bytes += generator.text('Bet On: ${receiptDetails.betOnName}');
      // bytes +=
      //     generator.text('Bet Amount: P${receiptDetails.betAmount.toString()}');
      // if (receiptDetails.claimedBy.isNotEmpty) {
      //   bytes += generator.text('Winnings: P${receiptDetails.winnings}');
      // }
      // // bytes += generator.text('POS Number: ${receiptDetails.posNumber}');
      // // bytes += generator.text('Cashier: ${receiptDetails.userName}');
      // bytes += generator.text('CreatedAt: ${receiptDetails.createdAt}');
      // bytes += generator.feed(2);

      // // Print QR code
      // bytes +=
      //     generator.qrcode(receiptDetails.transactionId, size: QRSize.size6);

      // // Add bottom padding
      // bytes += generator.feed(1);

      bytes += generator.text(
          isClaimedReceipt
              ? receiptDetails.claimedAt
              : receiptDetails.createdAt,
          styles: const PosStyles(
            align: PosAlign.center,
          ));

      bytes += generator.text(
          'Fight #${receiptDetails.fightNumber.toString()}: ${receiptDetails.betOnName}',
          styles: const PosStyles(
            align: PosAlign.left,
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          ));

      if (isClaimedReceipt) {
        bytes += generator.text('Claimed By: ${receiptDetails.claimedBy}',
            styles: const PosStyles(
              align: PosAlign.left,
              bold: true,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            ));
      }

      bytes += generator.text(
          '${isClaimedReceipt ? 'Bet Amount: ' : ''}P${receiptDetails.betAmount.toString()}',
          styles: PosStyles(
            align: PosAlign.left,
            bold: true,
            height: isClaimedReceipt ? PosTextSize.size1 : PosTextSize.size2,
            width: isClaimedReceipt ? PosTextSize.size1 : PosTextSize.size2,
          ));

      if (isClaimedReceipt) {
        bytes +=
            generator.text('Payout: P${receiptDetails.winnings}',
                styles: const PosStyles(
                  align: PosAlign.left,
                  bold: true,
                  height: PosTextSize.size1,
                  width: PosTextSize.size1,
                ));
      }

      bytes += generator.qrcode(receiptDetails.transactionId,
          size: QRSize.size6, align: PosAlign.left);

      bytes += generator.feed(1);

      bytes += generator.text(receiptDetails.transactionId,
          styles: const PosStyles(
            align: PosAlign.left,
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          ));

      bytes += generator.cut();
      return bytes;
    } catch (e) {
      if (context.mounted) {
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
          final isClaimedReceipt = receiptDetails.claimedBy.isNotEmpty;
          return pw.Padding(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    isClaimedReceipt
                        ? receiptDetails.claimedAt
                        : receiptDetails.createdAt,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 10,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Fight #${receiptDetails.fightNumber.toString()}: ${receiptDetails.betOnName}',
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
                pw.SizedBox(height: 10),
                if (isClaimedReceipt) ...[
                  pw.Text(
                    'Claimed By: ${receiptDetails.claimedBy}',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.SizedBox(height: 10),
                ],
                pw.Text(
                  '${isClaimedReceipt ? 'Bet Amount: ' : ''}₱${receiptDetails.betAmount.toString()}',
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: isClaimedReceipt ? 10 : 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
                pw.SizedBox(height: 10),
                if (isClaimedReceipt) ...[
                  pw.Text(
                    'Payout: ₱${receiptDetails.winnings}',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: isClaimedReceipt ? 10 : 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.SizedBox(height: 10),
                ],
                pw.Container(
                  width: double.infinity,
                  child: pw.BarcodeWidget(
                    data: receiptDetails.transactionId,
                    barcode: pw.Barcode.qrCode(),
                    width: 200,
                    height: 80,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  receiptDetails.transactionId,
                  style: pw.TextStyle(
                      font: ttf, fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Future<Uint8List> generatePdfPreview() async {
  //   final pdf = pw.Document();
  //   final fontData =
  //       await rootBundle.load('assets/fonts/roboto/Roboto-Regular.ttf');
  //   final ttf = pw.Font.ttf(fontData);
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: const PdfPageFormat(80 * PdfPageFormat.mm, double.infinity),
  //       build: (pw.Context context) {
  //         // final header = receiptDetails.claimedBy.isEmpty
  //         //     ? 'Official Receipt'
  //         //     : 'Claimed Receipt';
  //         return pw.Padding(
  //           padding:
  //               const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             children: [
  //               // pw.Text(
  //               //   header,
  //               //   style: pw.TextStyle(
  //               //       font: ttf, fontSize: 13, fontWeight: pw.FontWeight.bold),
  //               // ),
  //               // pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Transaction ID: ${receiptDetails.transactionId}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 10),
  //               ),
  //               // pw.SizedBox(height: 10),
  //               // pw.Text(
  //               //   'Event Name: ${receiptDetails.eventName}',
  //               //   style: pw.TextStyle(font: ttf, fontSize: 12),
  //               // ),
  //               // // pw.SizedBox(height: 10),
  //               // pw.Text(
  //               //   'Event Date: ${receiptDetails.eventDate}',
  //               //   style: pw.TextStyle(font: ttf, fontSize: 12),
  //               // ),
  //               // pw.SizedBox(height: 10),
  //               // pw.Text(
  //               //   'Location: ${receiptDetails.location}',
  //               //   style: pw.TextStyle(font: ttf, fontSize: 10),
  //               // ),
  //               // pw.SizedBox(height: 10),
  //               if (receiptDetails.claimedBy.isNotEmpty) ...[
  //                 pw.Text(
  //                   'Claimed By: ${receiptDetails.claimedBy}',
  //                   style: pw.TextStyle(font: ttf, fontSize: 10),
  //                 ),
  //                 pw.Text(
  //                   'Claimed At: ${receiptDetails.claimedAt}',
  //                   style: pw.TextStyle(font: ttf, fontSize: 10),
  //                 ),
  //               ],
  //               pw.Text(
  //                 'Fight Number: ${receiptDetails.fightNumber}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 10),
  //               ),
  //               // pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Bet On: ${receiptDetails.betOnName}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 10),
  //               ),
  //               // pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Bet Amount: ₱${receiptDetails.betAmount}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 10),
  //               ),
  //               if (receiptDetails.claimedBy.isNotEmpty) ...[
  //                 pw.Text(
  //                   'Winnings: ₱${receiptDetails.winnings}',
  //                   style: pw.TextStyle(font: ttf, fontSize: 10),
  //                 ),
  //               ],
  //               // pw.SizedBox(height: 10),
  //               // pw.Text(
  //               //   'POS Number: ${receiptDetails.posNumber}',
  //               //   style: pw.TextStyle(font: ttf, fontSize: 12),
  //               // ),
  //               // // pw.SizedBox(height: 10),
  //               // pw.Text(
  //               //   'Cashier: ${receiptDetails.userName}',
  //               //   style: pw.TextStyle(font: ttf, fontSize: 12),
  //               // ),
  //               // pw.SizedBox(height: 10),
  //               pw.Text(
  //                 'Created At: ${receiptDetails.createdAt}',
  //                 style: pw.TextStyle(font: ttf, fontSize: 10),
  //               ),
  //               pw.SizedBox(height: 10),
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

  Future<void> downloadPdf(Uint8List pdfData) async {
    await Printing.sharePdf(bytes: pdfData, filename: 'receipt_preview.pdf');
  }

  Future<void> _bluetoothPermissionHandler() async {
    final bool result =
        await PrintBluetoothThermal.isPermissionBluetoothGranted;
    if (!result) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enable bluetooth permission'),
          ),
        );
      }
    }
  }

  Future<void> _bluetoothEnabledHandler() async {
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (!result) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enable bluetooth'),
          ),
        );
      }
    }
  }

  Future<void> printReceiptUsingThermalPrinter() async {
    await _bluetoothPermissionHandler();
    await _bluetoothEnabledHandler();
    try {
      final List<BluetoothInfo> listResult =
          await PrintBluetoothThermal.pairedBluetooths;

      if (listResult.isEmpty) return;
      if (context.mounted) {
        final deviceNames = listResult.map((e) => e.name).join(', ');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(deviceNames),
          ),
        );
      }

      await PrintBluetoothThermal.connect(
          macPrinterAddress: listResult.first.macAdress);

      bool conectionStatus = await PrintBluetoothThermal.connectionStatus;
      if (conectionStatus) {
        List<int> ticket = await generateThermalPrinterReadyReceipt();
        if (ticket.isNotEmpty) {
          await PrintBluetoothThermal.writeBytes(ticket);
        }
      }
    } catch (e) {
      if (context.mounted) {
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
    required this.claimedBy,
    required this.claimedAt,
    required this.winnings,
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
  final String claimedBy;
  final String claimedAt;
  final String winnings;

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
    String? claimedBy,
    String? claimedAt,
    String? winnings,
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
      claimedBy: claimedBy ?? this.claimedBy,
      claimedAt: claimedAt ?? this.claimedAt,
      winnings: winnings ?? this.winnings,
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
        claimedBy,
        claimedAt,
        winnings,
      ];
}
