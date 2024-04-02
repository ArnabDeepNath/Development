import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';
import 'package:gspappfinal/utils/excelUtil.dart';
import 'package:gspappfinal/utils/pdfUtil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share/share.dart';

class ReportFunction extends StatefulWidget {
  const ReportFunction({super.key});

  @override
  State<ReportFunction> createState() => _ReportFunctionState();
}

class _ReportFunctionState extends State<ReportFunction> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          'Reports',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Generate Report'),
              value: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              items: [
                'GSTR1',
                'GSTR3A',
                'GSTR9',
                'Sale Reports',
                'Purchase Reports',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Generate report logic here

                    // String filePath = await generatePDF_GST(
                    //     'quotationId',
                    //     Timestamp.now(),
                    //     'name',
                    //     'address',
                    //     'phoneNumber',
                    //     'email',
                    //     'panId',
                    //     'gstId',
                    //     'optyId',
                    //     true,
                    //     'carLob',
                    //     'carModel',
                    //     0.0,
                    //     1,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     0,
                    //     [],
                    //     'username',
                    //     'userId',
                    //     PdfPageFormat(
                    //         PdfPageFormat.a4.width, PdfPageFormat.a4.height));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PDFViewerScreen(
                    //       filePath: filePath,
                    //       share: true,
                    //     ),
                    //   ),
                    // );
                    createExcelFile();
                  },
                  child: Text('Generate Report'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                  ),
                  onPressed: () {
                    // Generate report logic here
                  },
                  child: Container(
                    child: Text(
                      'One Click GST Filing',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String filePath;
  final bool share;

  const PDFViewerScreen({
    Key? key,
    required this.filePath,
    this.share = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        actions: [
          if (share)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                await Share.share(filePath);
              },
            ),
        ],
      ),
      body: PdfView(path: filePath),
    );
  }
}
