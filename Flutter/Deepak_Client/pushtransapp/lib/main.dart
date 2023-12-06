import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pushtransapp/dataModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Post Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HTTP Post Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String Balance = '';

  postData(
    String To,
    String from,
    String TemplateName,
    String VAR1,
    String VAR2,
    String VAR3,
  ) async {
    var response = await http.post(
      Uri.parse(
        "http://2factor.in/API/V1/1cd9adf0-baa3-11ec-8a9d-0200cd936042/ADDON_SERVICES/SEND/TSMS",
      ),
      body: {
        "To": To,
        "From": from,
        "TemplateName": TemplateName,
        "VAR1": VAR1,
        "VAR2": VAR2,
        "VAR3": VAR3,
      },
    );
    print(response.body);
    // DataModel dataModel = dataModelFromJson(response.body);
    // if (response.statusCode == 200) {
    //   setState(() {
    //     Balance = dataModel.status;
    //   });
    // }
  }

  late DataModel _dataModel;
  TextEditingController apicontroller = TextEditingController();
  TextEditingController tocontroller = TextEditingController();
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController TemplateNamecontroller = TextEditingController();
  TextEditingController Var1controller = TextEditingController();
  TextEditingController Var2controller = TextEditingController();
  TextEditingController Var3controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Send to Number',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: tocontroller,
            ),
            const Text(
              'Send from Number',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: fromcontroller,
            ),
            const Text(
              'Template Name',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: TemplateNamecontroller,
            ),
            const Text(
              'Variable Number 1 - Customer Name',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: Var1controller,
            ),
            const Text(
              'Variable Number 2 - Order Number',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: Var2controller,
            ),
            const Text(
              'Variable Number 3 - Service Status',
            ),
            SizedBox(
              width: 50,
            ),
            TextFormField(
              controller: Var3controller,
            ),
          ],
        ),
      ),
      floatingActionButton: Positioned(
        bottom: 150,
        right: 50,
        child: FloatingActionButton(
          onPressed: () {
            postData(
              tocontroller.text,
              fromcontroller.text,
              TemplateNamecontroller.text,
              Var1controller.text,
              Var2controller.text,
              Var3controller.text,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
