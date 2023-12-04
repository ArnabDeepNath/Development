import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future<String> generatePDF_Non_GST(
  // First Header
  String quotationId,
  Timestamp date,
  // Second Header
  String name,
  String address,
  String phoneNumber,
  String email,
  String panId,
  String gstId,
  String optyId,
  bool isGst,
  // Third Header (Calculation Module)
  String carLob,
  String carModel,
  double exShowRoomPrice,
  int qty,
  double tcs,
  double hsrp,
  double temp,
  double regn,
  int scheme,
  double grandTotal,
  // GST Module
  double sgct,
  double cgst,
  double aalgst,
  double baalgst,
  double totalAftertax,
  double totalTax,
  // Misceleanous Module
  List items,
  // User Details
  String username,
  String userId,
  PdfPageFormat format,
) async {
  final pdf = pw.Document();

  final logoData_1 = await rootBundle.load('images/logo1.png');
  final logoImage_1 = pw.MemoryImage(logoData_1.buffer.asUint8List());

  final logoData_2 = await rootBundle.load('images/logo2.png');
  final logoImage_2 = pw.MemoryImage(logoData_2.buffer.asUint8List());

  final logoData_3 = await rootBundle.load('images/signature.png');
  final signatureImg = pw.MemoryImage(logoData_3.buffer.asUint8List());

  final pw.TextStyle mainHeaderCellStyle = pw.TextStyle(
    fontSize: 12,
  );

  pw.TextStyle mainHeaderContentStyle = pw.TextStyle(
    fontSize: 10,
    fontWeight: pw.FontWeight.bold,
    background: const pw.BoxDecoration(
      color: PdfColors.grey300,
    ),
  );

  final pw.TextStyle secondTableStyle = pw.TextStyle(
    fontSize: 8,
    fontWeight: pw.FontWeight.bold,
  );

  final pw.TextStyle thirdTableContentStyle = pw.TextStyle(
    fontSize: 8,
  );

  final pw.TextStyle signatureContentStyle = pw.TextStyle(
    fontSize: 6,
    fontWeight: pw.FontWeight.bold,
  );

  const pw.TextStyle tableHeaderStyle4 = pw.TextStyle(
    fontSize: 8,
  );

  const pw.TextStyle tableContentStyle4 = pw.TextStyle(
    fontSize: 2,
    color: PdfColors.black,
  );

  const tableBorder = pw.TableBorder(
    left: pw.BorderSide(width: 1, color: PdfColors.black),
    top: pw.BorderSide(width: 1, color: PdfColors.black),
    right: pw.BorderSide(width: 1, color: PdfColors.black),
    bottom: pw.BorderSide(width: 1, color: PdfColors.black),
    horizontalInside: pw.BorderSide(width: 0, color: PdfColors.white),
    verticalInside: pw.BorderSide(width: 0, color: PdfColors.white),
  );
  // Assuming `widget.date` is a Firebase timestamp
  Timestamp timestamp = date;
  DateTime dateTime = timestamp.toDate();

  // Format the DateTime object into a string using DateFormat
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

  final pagetheme = await _pageTheme(format);
  pdf.addPage(
    pw.Page(
      pageTheme: pagetheme,
      build: (pw.Context context) {
        return pw.Positioned(
          top: 5,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Positioned(
                    child: pw.Container(
                      width: 80,
                      child: pw.Image(
                        logoImage_1,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    child: pw.Container(
                      width: 80,
                      child: pw.Image(
                        logoImage_2,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Positioned(
                child: pw.Text(
                  'MITHILA MOTORS PVT. LTD.',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Positioned(
                child: pw.Text(
                  'Authorised Commercial Vehicle Dealer',
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
              pw.Positioned(
                top: 7,
                left: 25,
                child: pw.Text(
                  'A3, IIND PHASE, ADITYAPUR KANDRA ROAD, JAMSHEDPUR - 829 109',
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
              pw.Positioned(
                top: 8,
                left: 25,
                child: pw.Text(
                  'TEL : 0657-6620701 (3 LINES), 6620708, 6620709 ',
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
              pw.Positioned(
                top: 10,
                left: 25,
                child: pw.Text(
                  'EMAIL : billing@mithilamotors.com, sales@mithilamotors.com',
                  style: const pw.TextStyle(
                    fontSize: 6,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 22,
              ),
              pw.Positioned(
                child: pw.SizedBox(
                  width: 520,
                  child: pw.Positioned(
                    top: 300,
                    child: pw.Table.fromTextArray(
                      cellStyle: mainHeaderCellStyle,
                      headerStyle: mainHeaderContentStyle,
                      headerDecoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      headerAlignments: {
                        0: pw.Alignment.center,
                      },
                      data: <List<String>>[
                        <String>['QUOTATION / PROFORMA INVOICE (Non - GST)'],
                      ],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                child: pw.SizedBox(
                  width: 520,
                  child: pw.Positioned(
                    child: pw.Table.fromTextArray(
                      border: tableBorder,
                      cellStyle: secondTableStyle,
                      headerStyle: signatureContentStyle,
                      headerDecoration: const pw.BoxDecoration(
                        color: PdfColors.white,
                      ),
                      cellAlignments: {
                        0: pw.Alignment.centerLeft,
                        1: pw.Alignment.centerLeft,
                        2: pw.Alignment.centerLeft,
                        3: pw.Alignment.centerRight,
                      },
                      // cellAlignment: pw.Alignment.center,
                      data: <List<String>>[
                        <String>[''],
                        <String>['Quotation No: ', quotationId],
                        <String>['Date: ', formattedDate],
                        <String>[''],
                      ],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                bottom: 125,
                child: pw.SizedBox(
                  width: 520,
                  child: pw.Positioned(
                    top: 300,
                    child: pw.Table.fromTextArray(
                      border: tableBorder,
                      cellStyle: thirdTableContentStyle,
                      headerStyle: signatureContentStyle,
                      cellAlignments: {
                        0: pw.Alignment.centerLeft,
                        1: pw.Alignment.bottomLeft,
                      },
                      data: <List<String>>[
                        <String>[''],
                        <String>[
                          'Name: ',
                          name,
                        ],
                        <String>[
                          'Phone No:',
                          phoneNumber,
                        ],
                        <String>[
                          'Email: ',
                          email,
                        ],
                        <String>[
                          'PAN No: ',
                          panId,
                        ],
                        <String>[
                          'GST No: ',
                          gstId,
                        ],
                        <String>[
                          'OPTY No: ',
                          optyId,
                        ],
                        <String>[
                          '',
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                top: 125,
                child: pw.SizedBox(
                  width: 520,
                  child: pw.Positioned(
                    child: pw.Table.fromTextArray(
                      cellStyle: thirdTableContentStyle,
                      headerStyle: signatureContentStyle,
                      headerDecoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      cellAlignments: {
                        0: pw.Alignment.center,
                        1: pw.Alignment.center,
                        2: pw.Alignment.center,
                        3: pw.Alignment.center,
                        4: pw.Alignment.center,
                        5: pw.Alignment.center,
                      },
                      headerAlignments: {
                        0: pw.Alignment.center,
                      },
                      data: <List<dynamic>>[
                        <String>[
                          'Model',
                          'Quantity',
                          'Unit Price',
                          'Amount',
                        ],
                        <String>[
                          carModel,
                          qty.toString(),
                          '',
                          'Rs. $exShowRoomPrice',
                        ],
                        <String>[
                          'Scheme',
                          qty.toString(),
                          '',
                          'Rs. $scheme',
                        ],
                        <String>[
                          '',
                          '',
                          '',
                          '',
                        ],
                        <String>[
                          '',
                          '',
                          '',
                          '',
                        ],
                        <String>[
                          'TCS @ 01.00%',
                          '',
                          '',
                          'Rs. $tcs',
                        ],
                        ...items
                            .map((item) => [
                                  item['name'],
                                  item['quantity'].toString(),
                                  'Rs. ${item['price'].toString()}',
                                ])
                            .toList(),
                        <String>[
                          'Total Tax',
                          '',
                          '',
                          'Rs. $totalTax',
                        ],
                        <String>[
                          'Total After Tax',
                          '',
                          '',
                          'Rs. $totalAftertax',
                        ],
                        <String>[
                          'REGN + TEMP',
                          '',
                          '',
                          'Rs. ${regn + temp}',
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                bottom: 125,
                child: pw.SizedBox(
                  width: 520,
                  child: pw.Positioned(
                    top: 300,
                    child: pw.Table.fromTextArray(
                      defaultColumnWidth: const pw.FixedColumnWidth(150),
                      cellStyle: tableContentStyle4,
                      headerStyle: tableHeaderStyle4,
                      cellAlignments: {
                        0: pw.Alignment.topLeft,
                        1: pw.Alignment.center,
                        2: pw.Alignment.center,
                        3: pw.Alignment.center,
                        4: pw.Alignment.center,
                        5: pw.Alignment.center,
                      },
                      headerAlignments: {
                        0: pw.Alignment.centerLeft,
                      },
                      cellAlignment: pw.Alignment.topLeft,
                      data: <List<String>>[
                        <String>[
                          'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. \n3 TCS @ 01.00% shall be applicable on Billing Price with ITR for 2021-22 else TCS@ 5% will be charged. (Ref : Circular No 11 of 2021 dt 21st June2021 of Ministry of Finance. \n4 TCS once collected is non refundable in case of cancellation of invoiced vehicle. \n5 Prices are for current specifications and are subject to change without notice. \n6 Prices and additional charges as above will have to be paid completely, to conclude the sales. \n7 Payment for all the above items will be by demand drafts/cheques, favoring MITHILA MOTORS PRIVATE LIMITEDpayable atJAMSHEDPUR. RTGS DETAILS: HDFC BANK,A/C NO-00872840000136,IFSC CODE – HDFC0000087 ,BISTUPUR JAMSHEDPUR. \n8 Delivery will be effected after two days of completion of finance documentation, submission of PDCs, approval &disbursment of loans etc. \n9 Acceptance of advance/deposit by seller is merely an indication of an intention to sell and does not result into a contract of sale \n10 The company shall not be liable due to any prevention, hindrance, or delay in manufacture, delivery of vehicles or accessories / optionals due to shortage of material, strike, riot, civil commotion,accident, machinery breakdown government policies, acts of god and nature, and all events beyond the control of the company. \n11 The seller shall have a general lien on goods for all moneys due to seller from buyer on account of this or other transaction. \n12 This is to inform all our esteemed customers that any advance payments for purchase of vehicles made by them to us are our own liability and our Principals M/S Tata Motors Ltd. are in no way,implicitly or explicitly responsible for any vicarious liability for the refund of advance or delivery of vehicles thereof, as they deal with us on a Principal to Principal basis. \n14 Cancellation charge @Rs.10000/- will be applicable in list of cancellation after billing \n15 All disputes arising between the parties hereto shall be referred to arbitration according to the arbitration laws of the country. Only the courts of JAMSHEDPUR shall have jurisdiction in any proceedings relating to this contract.'
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                bottom: 165,
                child: pw.Container(
                  width: 520,
                  decoration: const pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Company will not be responsible for any transaction in cash except at Dealership \ncash counter',
                        style: pw.TextStyle(
                          fontSize: 8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Positioned(
                    bottom: 105,
                    child: pw.SizedBox(
                      width: 520,
                      child: pw.Positioned(
                        top: 300,
                        child: pw.Table.fromTextArray(
                          defaultColumnWidth: const pw.FixedColumnWidth(30),
                          cellStyle: thirdTableContentStyle,
                          headerStyle: signatureContentStyle,
                          headerDecoration: const pw.BoxDecoration(
                            color: PdfColors.grey300,
                          ),
                          cellAlignments: {
                            0: pw.Alignment.center,
                            1: pw.Alignment.center,
                            2: pw.Alignment.center,
                            3: pw.Alignment.center,
                            4: pw.Alignment.center,
                            5: pw.Alignment.center,
                          },
                          headerAlignments: {
                            0: pw.Alignment.centerRight,
                          },
                          cellAlignment: pw.Alignment.center,
                          data: <List<String>>[
                            <String>[
                              'Created By : $username ',
                              'User ID.: $userId',
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.Positioned(
                    child: pw.Container(
                      width: 100,
                      child: pw.Image(
                        signatureImg,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );

  // Create a file to save the PDF
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/invoice_$quotationId.pdf');

  // Save the PDF to the file
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.buffer.asInt8List());

  return file.path;
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  final image = pw.MemoryImage(
      (await rootBundle.load('images/watermark.png')).buffer.asUint8List());
  return pw.PageTheme(
    margin: pw.EdgeInsets.zero,
    pageFormat: PdfPageFormat.a4,
    buildBackground: ((context) => pw.FullPage(
          ignoreMargins: false,
          child: pw.Watermark(
            angle: 32,
            child: pw.Opacity(
              opacity: 0.15,
              child: pw.Image(image),
            ),
          ),
        )),
  );
}
