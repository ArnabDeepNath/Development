import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static Future<void> showProgressDialog(
      BuildContext context, String message) async {
    return showDialog<void>(
        context: context,
        routeSettings: const RouteSettings(name: '/loaderDialog'),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Row(children: [
                      Container(
                        child: const CircularProgressIndicator(),
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 8.0, bottom: 8.0),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ])
                  ]));
        });
  }

  static void hideProgressDialog(BuildContext context) {
    Navigator.popUntil(context, (route) {
      if (route.settings.name == '/loaderDialog') {
        return false;
      }
      return true;
    });
  }

  static bool validateMobile(String value) {
    if (value != '' && value.length == 10) {
      if (value.startsWith('9') ||
          value.startsWith('8') ||
          value.startsWith('7') ||
          value.startsWith('6')) {
        return true;
      }
    }
    return false;
  }

  static bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern);
      return (!regex.hasMatch(value)) ? false : true;
    }
  }

  /*static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/

  static String formatDate(int dateMs, String format, bool toFormat) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(dateMs);
    String dateString = DateFormat(format).format(date);
    if (toFormat) {
      return "(" + dateString + ")";
    }
    return dateString;
  }

  static DateTime dateConversion(String dateString, String format) {
    var dateTime = DateFormat(format).parse(dateString);
    return dateTime;
  }

  static String formatDateApi(String dateToBeForamt) {
    var inputFormat = DateFormat("dd-MM-yyyy");
    var date1 = inputFormat.parse(dateToBeForamt);
    String dateString = DateFormat("yyyy-MM-dd").format(date1);
    return dateString;
  }

  static String formatDateApiGeneric(
      String dateToBeForamt, String inputDateFormat, String outputDateFormat) {
    var inputFormat = DateFormat(inputDateFormat);
    var date1 = inputFormat.parse(dateToBeForamt);
    String dateString = DateFormat(outputDateFormat).format(date1);
    return dateString;
  }

  static void showSnakeBar(BuildContext context, String msg) {
    final snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
