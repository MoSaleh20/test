import 'dart:convert';

Payment paymentFromMap(String str) => Payment.fromMap(json.decode(str));

String paymentToMap(Payment data) => json.encode(data.toMap());

class Payment {
  Payment({
    this.amount,
    this.date,
    this.customerName,
  });

  double amount;
  String date;
  String customerName;

  factory Payment.fromMap(Map<String, dynamic> data) {
    return Payment(
      amount: data['amount'],
      date: data['date'],
      customerName: data['customerName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': this.amount,
      'date': this.date,
      'customerName': this.customerName,
    };
  }
}
