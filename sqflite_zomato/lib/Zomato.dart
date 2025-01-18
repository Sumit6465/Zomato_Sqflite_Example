import 'package:flutter/foundation.dart';

class Zomato {
  final int orderNo;
  final String custName;
  final String hotelName;
  final String food;
  final double bill;

  const Zomato(
      {required this.orderNo,
      required this.food,
      required this.custName,
      required this.hotelName,
      required this.bill});
  Map<String, dynamic> zomatoMap() {
    return {
      'orderNo': orderNo,
      'custName': custName,
      'hotelName': hotelName,
      'food': food,
      'bill': bill,
    };
  }
}
