import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GST1 extends StatefulWidget {
  GST1({super.key});

  // B2B Function -> Details of Invoices of Taxable SUpplies to Registered Person
  // B2B A Function -> Amended Details
  // B2C Large Function -> Invoices for Outward supplies with conditions
  // B2C Large A Funtion -> Amended Details
  // B2C Small Function ->  Supplies made to unregistered Person
  // B2C Small A Function -> Amended Details
  // Credit/Debit Note Function -> Credit/Debit Note to Registered Person
  // Amended C/D Note Function -> Amended Details
  // Credit/Debit Note Function -> Credit/Debit Note to Unregistered Person
  // Export Function -> Export Supplies
  // Amended Export Function -> Amended Details
  // Tax Liabitlity Function -> Advance
  // Amended Details -> Amended Details
  // Advance Adjustments ->
  // Amended Advance Adjustments ->
  // Nil Rated , Exempted and Non GST supplies ->
  // HSN Summary ->
  // List of Documents ->

  TextEditingController GSTID = TextEditingController();
  // GSTID of the Party you are selling to
  TextEditingController Rname = TextEditingController();
  // Name of the Party
  TextEditingController InvoiceNo = TextEditingController();
  // Invoice Number -> Auto
  TextEditingController InvoiceDate = TextEditingController();
  // Invoice Date -> Auto
  TextEditingController InvoiceValue = TextEditingController();
  // Invoice Value -> Items Total Cost
  TextEditingController POS = TextEditingController();
  // Place of Supply -> Dropdown -> Constant Data
  TextEditingController TaxRatePercent = TextEditingController();
  // Tax Percent -> Dropdown -> Either 65 or blank
  TextEditingController ReverseCharge = TextEditingController();
  // Reverse Charge -> Dropdown -> Either Yes or No
  TextEditingController EGSTID = TextEditingController();
  // Ecommerce GST ID -> Non Mandatory
  TextEditingController InvoiceType = TextEditingController();
  // Invoice Type -> Dropdown -> Constant Data
  TextEditingController Rate = TextEditingController();
  // Rate -> Dropdown -> Constant Data
  TextEditingController TaxableValue = TextEditingController();
  // Taxable Amount -> Auto
  TextEditingController CESS = TextEditingController();
  // CESS Amount -> Auto

  @override
  State<GST1> createState() => _GST1State();
}

class _GST1State extends State<GST1> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
