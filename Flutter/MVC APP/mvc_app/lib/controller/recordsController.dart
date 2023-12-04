import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveInvoice_Non_GST(
    // First Header
    String quotation_id,
    String date,
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
    double totalTax,
    double totalAftertax,
    // Misceleanous Module
    List items,
    // User Details
    String username,
    String userId,
  ) async {
    try {
      await _firestore.collection('invoices').add({
        'quotation_id': quotation_id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'gst_id': gstId,
        'pan_id': panId,
        'opty_id': optyId,
        'isGst': false,
        'unit_price': exShowRoomPrice,
        'modelName': carModel,
        'lob': carLob,
        'quantity': qty,
        'scheme': scheme,
        'items': items.map((item) {
          return {
            'name': item['name'],
            'quantity': item['quantity'],
            'price': item['price'],
          };
        }).toList(),
        'tcs': tcs,
        'hsrp': hsrp,
        'temp': temp,
        'regn': regn,
        'grandTotal': grandTotal,
        'sgst': sgct,
        'cgst': cgst,
        'totalTax': totalTax,
        'TotalAfterTax': totalAftertax,
        'createdAt': FieldValue.serverTimestamp(),
        'editCounter': 0,
        'userId': userId,
        'createdBy': username,
      });
    } catch (e) {
      // print('Error saving invoice: $e');
      throw Exception('Failed to save invoice');
    }
  }

  Future<void> saveInvoice_GST(
    // First Header
    String quotation_id,
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
  ) async {
    try {
      await _firestore.collection('invoices').add({
        'quotation_id': quotation_id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'gst_id': gstId,
        'pan_id': panId,
        'opty_id': optyId,
        'isGst': true,
        'unit_price': exShowRoomPrice,
        'modelName': carModel,
        'lob': carLob,
        'quantity': qty,
        'scheme': scheme,
        'items': items.map((item) {
          return {
            'name': item['name'],
            'quantity': item['quantity'],
            'price': item['price'],
          };
        }).toList(),
        'tcs': tcs,
        'hsrp': hsrp,
        'temp': temp,
        'regn': regn,
        'grandTotal': grandTotal,
        'sgst': sgct,
        'cgst': cgst,
        'totalTax': totalTax,
        'TotalAfterTax': totalAftertax,
        'createdAt': FieldValue.serverTimestamp(),
        'editCounter': 0,
        'userId': userId,
        'createdBy': username,
      });
    } catch (e) {
      // print('Error saving invoice: $e');
      throw Exception('Failed to save invoice');
    }
  }

  Future<void> updateInvoice_Non_GST(
    // First Header
    String? quotation_id,
    Timestamp date,
    // Second Header
    String? name,
    String? address,
    String? phoneNumber,
    String? email,
    String? panId,
    String? gstId,
    String? optyId,
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
  ) async {
    try {
      // Query the invoice with the specified quotation_id
      final invoiceQuery = await _firestore
          .collection('invoices')
          .where('quotation_id', isEqualTo: quotation_id)
          .get();

      // Get the first document from the query result
      final invoiceDoc = invoiceQuery.docs.first;

      // Update the document fields with the new values
      await invoiceDoc.reference.update({
        'quotation_id': quotation_id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'gst_id': gstId,
        'pan_id': panId,
        'opty_id': optyId,
        'isGst': false,
        'unit_price': exShowRoomPrice,
        'modelName': carModel,
        'lob': carLob,
        'quantity': qty,
        'scheme': scheme,
        'items': items
            .map((item) => {'name': item['name'], 'quantity': item['quantity']})
            .toList(),
        'tcs': tcs,
        'hsrp': hsrp,
        'temp': temp,
        'regn': regn,
        'grandTotal': grandTotal,
        'sgst': sgct,
        'cgst': cgst,
        'totalTax': totalTax,
        'TotalAfterTax': totalAftertax,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update the quotation number
      await updateQuotationNo(quotation_id!);
      // print('Function call succesfull ✅');
    } catch (e) {
      // print('Error updating invoice: $e');
      throw Exception('Failed to update invoice');
    }
  }

  Future<void> updateInvoice_GST(
    // First Header
    String? quotation_id,
    Timestamp date,
    // Second Header
    String? name,
    String? address,
    String? phoneNumber,
    String? email,
    String? panId,
    String? gstId,
    String? optyId,
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
  ) async {
    try {
      // Query the invoice with the specified quotation_id
      final invoiceQuery = await _firestore
          .collection('invoices')
          .where('quotation_id', isEqualTo: quotation_id)
          .get();

      // Get the first document from the query result
      final invoiceDoc = invoiceQuery.docs.first;

      // Update the document fields with the new values
      await invoiceDoc.reference.update({
        'quotation_id': quotation_id,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address,
        'gst_id': gstId,
        'pan_id': panId,
        'opty_id': optyId,
        'isGst': true,
        'unit_price': exShowRoomPrice,
        'modelName': carModel,
        'lob': carLob,
        'quantity': qty,
        'scheme': scheme,
        'items': items
            .map((item) => {'name': item['name'], 'quantity': item['quantity']})
            .toList(),
        'tcs': tcs,
        'hsrp': hsrp,
        'temp': temp,
        'regn': regn,
        'grandTotal': grandTotal,
        'sgst': sgct,
        'cgst': cgst,
        'totalTax': totalTax,
        'TotalAfterTax': totalAftertax,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update the quotation number
      await updateQuotationNo(quotation_id!);
      // print('Function call succesfull ✅');
    } catch (e) {
      // print('Error updating invoice: $e');
      throw Exception('Failed to update invoice');
    }
  }

  Future<void> updateQuotationNo(String quotationId) async {
    // print(quotationId);
    final invoiceRef = await _firestore
        .collection('invoices')
        .where('quotation_id', isEqualTo: quotationId)
        .get()
        .then((value) => value.docs.first.reference);
    final invoice = await invoiceRef.get();
    final currentQuotationNo = invoice['quotation_id'] ?? '';
    final currentEditCounter = invoice['editCounter'] ?? 0;
    final newEditCounter = currentEditCounter + 1;
    final existingQuotationParts = currentQuotationNo.split('-EN-');
    final newQuotationNo = '${existingQuotationParts.first}-EN-$newEditCounter';
    await invoiceRef.update({
      'editCounter': newEditCounter,
      'quotation_id': newQuotationNo,
    });
  }
}
