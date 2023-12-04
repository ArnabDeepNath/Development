import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_app/controller/invoiceController_GST.dart';
import 'package:mvc_app/view/updateInvoice_GST.dart';
import 'package:pdf/pdf.dart';
import 'package:share/share.dart';

import '../model/carModel.dart';

class editInvoicePage_GST_admin extends StatefulWidget {
  @override
  _editInvoicePage_GST_adminState createState() =>
      _editInvoicePage_GST_adminState();
}

class _editInvoicePage_GST_adminState extends State<editInvoicePage_GST_admin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _currentUserId = "";

  @override
  void initState() {
    super.initState();
    getCurrentUserId();
  }

  Future<String> getCurrentUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid;
    setState(() {
      _uid = uid;
      _currentUserId = uid;
    });
    print(_currentUserId);
    return uid;
  }

  late String _uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Text(''),
        title: Text('Edit Quotation GST , Admin Edition'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('invoices')
            .where('isGst', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'You have not added any invoices yet',
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.remove_red_eye),
                            title: const Text('View PDF'),
                            onTap: () async {
                              final String filePath = await generatePDF_GST(
                                document['quotation_id'],
                                document['createdAt'],
                                document['name'],
                                document['address'],
                                document['phoneNumber'],
                                document['email'],
                                document['pan_id'],
                                document['gst_id'] ?? '',
                                document['opty_id'],
                                true,
                                document['lob'],
                                document['modelName'],
                                document['unit_price'],
                                document['quantity'],
                                document['tcs'],
                                0,
                                document['temp'],
                                document['regn'],
                                document['scheme'],
                                document['grandTotal'],
                                document['sgst'],
                                document['cgst'],
                                0,
                                0,
                                document['TotalAfterTax'],
                                document['totalTax'],
                                document['items'],
                                document['userId'],
                                document['createdBy'],
                                PdfPageFormat(PdfPageFormat.a4.width,
                                    PdfPageFormat.a4.height),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewerScreen(
                                    filePath: filePath,
                                    share: true,
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.share),
                            title: const Text('Share PDF'),
                            onTap: () async {
                              Navigator.pop(context);

                              // Generate the PDF file
                              final String filePath = await generatePDF_GST(
                                document['quotation_id'],
                                document['createdAt'],
                                document['name'],
                                document['address'],
                                document['phoneNumber'],
                                document['email'],
                                document['pan_id'],
                                document['gst_id'],
                                document['opty_id'],
                                true,
                                document['lob'],
                                document['modelName'],
                                document['unit_price'],
                                document['quantity'],
                                document['tcs'],
                                0,
                                document['temp'],
                                document['regn'],
                                document['scheme'],
                                document['grandTotal'],
                                document['sgst'],
                                document['cgst'],
                                0,
                                0,
                                document['TotalAfterTax'],
                                document['totalTax'],
                                document['items'],
                                document['userId'],
                                document['createdBy'],
                                PdfPageFormat(PdfPageFormat.a4.width,
                                    PdfPageFormat.a4.height),
                              );

                              // Share the PDF file
                              Share.shareFiles([filePath],
                                  subject: 'Invoice PDF');
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete Document'),
                            onTap: () async {
                              Navigator.pop(context);

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text(
                                        'Are you sure you want to delete this document?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(
                                              context); // Close the dialog

                                          // Fetch the document ID using the quotation number
                                          QuerySnapshot querySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'invoices') // Replace with your collection name
                                                  .where('quotation_id',
                                                      isEqualTo: document[
                                                          'quotation_id'])
                                                  .get();

                                          if (querySnapshot.docs.isNotEmpty) {
                                            // Get the first document from the query result
                                            String documentId =
                                                querySnapshot.docs[0].id;

                                            // Delete the document from Firestore
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    'invoices') // Replace with your collection name
                                                .doc(documentId)
                                                .delete();

                                            // Perform any additional operations or show a confirmation message
                                            // after successful deletion.
                                          } else {
                                            // Handle case when no document is found with the given quotation number
                                          }
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['quotation_id']),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Navigate to the update invoice screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => updateInvoice_GST(
                            selectedLob: document['lob'],
                            selectedModel: document['modelName'],
                            quotation_no: document['quotation_id'],
                            name: document['name'],
                            phonenumber: document['phoneNumber'],
                            address: document['address'],
                            date: document['createdAt'],
                            email: document['email'],
                            pan_id: document['pan_id'],
                            opt_id: document['opty_id'],
                            scheme: document['scheme'],
                            tcs: document['tcs'],
                            exShowRoomPrice: document['unit_price'],
                            qty: document['quantity'],
                            hsrp: document['hsrp'],
                            regn: document['regn'],
                            temp_regn: document['temp'],
                            totalAfterTax: document['TotalAfterTax'],
                            totalTax: document['totalTax'],
                            items: document['items'],
                            gstId: document['gst_id'],
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
