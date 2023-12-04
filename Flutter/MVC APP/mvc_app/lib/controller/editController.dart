import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_app/model/carModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share/share.dart';

Future<String> editPDF(
  String name,
  String address,
  String phone,
  List<Car> cars,
  PdfPageFormat format,
  int editNumber,
) async {
  // Create a PDF document
  // Add image watermark

  final pdf = pw.Document();
  final watermark = pw.Watermark(
    child: pw.Text(
      'Mitila Motors',
      style: pw.TextStyle(
        color: PdfColors.grey,
        fontSize: 50,
      ),
    ),
  );

  // Define the styles to be used in the document
  final pw.TextStyle titleStyle = pw.TextStyle(
    fontSize: 28,
    fontWeight: pw.FontWeight.bold,
  );

  final pw.TextStyle subtitleStyle = pw.TextStyle(
    fontSize: 18,
    fontWeight: pw.FontWeight.bold,
  );
  final List<String> headerData = ['Quotation'];

  final pw.TextStyle tableHeaderStyle = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
  );
  final headerRow = pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Text(
          'Quotation',
          style: tableHeaderStyle,
        ),
      ),
    ],
  );

  final pw.TextStyle tableContentStyle = pw.TextStyle(
    fontSize: 11,
  );

  final date = '1/04/2023';
  final scheme = '12656';

  final pagetheme = await _pageTheme(format);
  pdf.addPage(
    pw.Page(
      pageTheme: pagetheme,
      build: (pw.Context context) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.Container(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: <pw.Widget>[
                  pw.Expanded(
                    flex: 2,
                    child: pw.Stack(
                      children: [
                        pw.Text(
                          'Mithila Motors',
                          style: pw.TextStyle(
                            fontSize: 62,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),

                        pw.Positioned(
                          top: 58,
                          child: pw.Text(
                            'A part of Tata Motors',
                            style: pw.TextStyle(
                              fontSize: 28,
                              fontWeight: pw.FontWeight.normal,
                            ),
                          ),
                        ),
                        // pw.Positioned(
                        //   top: 90,
                        //   left: 10,
                        //   child: pw.Container(
                        //     decoration: pw.BoxDecoration(
                        //       borderRadius: pw.BorderRadius.circular(12),
                        //     ),
                        //     child: pw.Expanded(
                        //       flex: 2,
                        //       child: pw.Column(
                        //         mainAxisAlignment: pw.MainAxisAlignment.start,
                        //         children: [
                        //           pw.SizedBox(height: 20),
                        //           pw.Text(
                        //             'Customer Information',
                        //             style: pw.TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: pw.FontWeight.bold,
                        //             ),
                        //           ),
                        //           pw.SizedBox(height: 10),
                        //           pw.Text(
                        //             'Name: $name',
                        //             style: pw.TextStyle(fontSize: 14),
                        //           ),
                        //           pw.Text(
                        //             'Address: $address',
                        //             style: pw.TextStyle(fontSize: 14),
                        //           ),
                        //           pw.Text(
                        //             'Phone: $phone',
                        //             style: pw.TextStyle(fontSize: 14),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // pw.Positioned(
                        //   top: 70,
                        //   child: pw.Expanded(
                        //     flex: 1,
                        //     child: pw.Row(
                        //       mainAxisAlignment: pw.MainAxisAlignment.end,
                        //       children: [
                        //         pw.Text(
                        //           'Invoice Items',
                        //           style: pw.TextStyle(
                        //             fontSize: 18,
                        //             fontWeight: pw.FontWeight.bold,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        pw.SizedBox(
                          height: 22,
                        ),
                        pw.Positioned(
                          top: 92,
                          child: pw.Container(
                            width: 650,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey300,
                            ),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'QUOTATION / PROFORMA INVOICE',
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Positioned(
                          top: 125,
                          child: pw.SizedBox(
                            width: 420,
                            child: pw.Positioned(
                              top: 300,
                              child: pw.Table.fromTextArray(
                                cellStyle: tableContentStyle,
                                headerStyle: tableHeaderStyle,
                                headerDecoration: pw.BoxDecoration(
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
                                // columnWidths: {
                                //   0: pw.FlexColumnWidth(20),
                                //   // 1: pw.FlexColumnWidth(2),
                                //   // 2: pw.FlexColumnWidth(4),
                                //   // 3: pw.FlexColumnWidth(5),
                                //   // 4: pw.FlexColumnWidth(3),
                                //   // 5: pw.FlexColumnWidth(3),
                                // },
                                cellAlignment: pw.Alignment.center,

                                data: <List<String>>[
                                  // headerData,
                                  // <String>['Quotation'],
                                  <String>[''],
                                  <String>[
                                    'Quotation No: ',
                                    (editNumber + 1).toString(),
                                    'Date: ',
                                    date
                                  ],
                                  <String>[''],
                                  <String>[
                                    'Name: Arnab \nAddress: IITG \n',
                                    'PAN No.: Arnab '
                                        'Opty Id: : IITG ',
                                  ],
                                  <String>[
                                    'Description',
                                    'Quantity',
                                    'Unit Price',
                                    'Amount'
                                  ],
                                  ...cars.map((car) => <String>[
                                        car.model,
                                        '1',
                                        '\Rs. ${car.exShowroomPrice.toStringAsFixed(2)}',
                                        '\Rs. ${car.exShowroomPrice.toStringAsFixed(2)}',
                                      ]),
                                  <String>['Scheme: ', '1', '- Rs.${scheme}'],
                                  <String>['TCS: ', '', date],
                                  <String>[
                                    'Prices prevailing at the time of billing shall be applicable',
                                    'Total: (Ex-Showroom Price)',
                                    '',
                                    'Rs. 15686'
                                  ],
                                  <String>[''],
                                  <String>['Temp + REGN', '', '', 'Rs. 3520'],
                                  <String>[
                                    'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                    'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                    'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                    'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                  ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ]
                                ],
                              ),
                            ),
                          ),
                        ),
                        pw.Positioned(
                          bottom: 165,
                          child: pw.Container(
                            width: 650,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey300,
                            ),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'Company will not be responsible for any transaction in cash except at Dealership \ncash counter',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.Positioned(
                          bottom: 125,
                          child: pw.SizedBox(
                            width: 420,
                            child: pw.Positioned(
                              top: 300,
                              child: pw.Table.fromTextArray(
                                cellStyle: tableContentStyle,
                                headerStyle: tableHeaderStyle,
                                headerDecoration: pw.BoxDecoration(
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
                                // columnWidths: {
                                //   0: pw.FlexColumnWidth(20),
                                //   // 1: pw.FlexColumnWidth(2),
                                //   // 2: pw.FlexColumnWidth(4),
                                //   // 3: pw.FlexColumnWidth(5),
                                //   // 4: pw.FlexColumnWidth(3),
                                //   // 5: pw.FlexColumnWidth(3),
                                // },
                                cellAlignment: pw.Alignment.center,

                                data: <List<String>>[
                                  // headerData,
                                  // <String>['Quotation'],
                                  // <String>[''],
                                  // <String>[
                                  //   'Quotation No: ',
                                  //   '',
                                  //   'Date: ',
                                  //   date
                                  // ],
                                  // <String>[''],
                                  <String>[
                                    'GST No: BREPN0643Q',
                                    'PAN No.: OJPD930393 ',
                                  ],
                                  // <String>[
                                  //   'Description',
                                  //   'Quantity',
                                  //   'Unit Price',
                                  //   'Amount'
                                  // ],
                                  // ...cars.map((car) => <String>[
                                  //       car.model,
                                  //       '1',
                                  //       '\Rs. ${car.exShowroomPrice.toStringAsFixed(2)}',
                                  //       '\Rs. ${car.exShowroomPrice.toStringAsFixed(2)}',
                                  //     ]),
                                  // <String>['Scheme: ', '1', '- Rs.${scheme}'],
                                  // <String>['TCS: ', '', date],
                                  // <String>[
                                  //   'Prices prevailing at the time of billing shall be applicable',
                                  //   'Total: (Ex-Showroom Price)',
                                  //   '',
                                  //   'Rs. 15686'
                                  // ],
                                  // <String>[''],
                                  // <String>['Temp + REGN', '', '', 'Rs. 3520'],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. ',
                                  // ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ],
                                  // <String>[
                                  //   'Terms and conditions \n1 Prices prevailing at the time of delivery will be applicable irrespective of when the Order placed. \n2 Optionals, accessories, taxes, octroi, other levies etc. will be charged extra as applicable. '
                                  // ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // pw.SizedBox(
                  //   height: 22,
                  // ),

                  // pw.SizedBox(
                  //   height: 22,
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // Create a file to save the PDF
  final directory = await getTemporaryDirectory();
  final file = File(directory.path + '/invoice.pdf');

  // Save the PDF to the file
  final pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes.buffer.asInt8List());
  Share.shareFiles([file.path], subject: 'Invoice PDF');
  print('Successful');
  return file.path;
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  final image = pw.MemoryImage(
      (await rootBundle.load('images/watermark.png')).buffer.asUint8List());
  return pw.PageTheme(
    pageFormat: PdfPageFormat.a4.copyWith(
      marginLeft: 40,
      marginRight: 120,
      marginTop: 0,
    ),
    buildBackground: ((context) => pw.FullPage(
          ignoreMargins: false,
          child: pw.Watermark(
            child: pw.Opacity(
              opacity: 0.15,
              child: pw.Image(image),
            ),
          ),
        )),
  );
}
