import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String name;
  final double price;
  final Timestamp creationDate;

  Item({
    required this.name,
    required this.price,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'creationDate': creationDate,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      price: map['price'],
      creationDate: map['creationDate'],
    );
  }
}
