// To parse this JSON data, do
//
// final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.status,
    required this.details,
  });

  String status;
  String details;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json["Status"],
        details: json["Details"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Details": details,
      };
}
