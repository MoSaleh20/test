import 'package:meta/meta.dart';
import 'dart:convert';

Customer customerFromMap(String str) => Customer.fromMap(json.decode(str));

String customerToMap(Customer data) => json.encode(data.toMap());

class Customer {
  Customer({
    @required this.id,
    @required this.name,
    this.dept,
    this.inDept,
    this.date,
    this.payment,
    this.phone,
    this.balance,
  }) {
    if (this.balance == null) {
      this.balance = 0;
    }
    if (this.payment == null) {
      this.payment = 0;
    }
    if (this.dept == null) {
      this.dept = 0;
    }
    if (this.inDept == null) {
      this.inDept = 0;
    }
  }

  int id;
  String name;
  double dept = 0;
  int inDept = 0;
  String date;
  double payment = 0;
  String phone;
  double balance = 0;

  factory Customer.fromMap(Map<String, dynamic> data) {
    return Customer(
      id: data['id'],
      name: data['name'],
      dept: data['dept'],
      inDept: data['inDept'],
      date: data['date'],
      payment: data['payment'],
      phone: data['phone'],
      balance: data['balance'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'dept': this.dept,
      'inDept': this.inDept,
      'date': this.date,
      'payment': this.payment,
      'phone': this.phone,
      'balance': this.balance,
    };
  }
}
