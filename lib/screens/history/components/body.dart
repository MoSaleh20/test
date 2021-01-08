import 'package:flutter/material.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import '../../../databaseProvider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<PubgUc> invoices = [];

    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder(
          future: DatabaseProvider.db.orders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              invoices = snapshot.data;
              allInvoices = invoices;
              invoices.sort((a, b) {
                return b.date
                    .toString()
                    .toLowerCase()
                    .compareTo(a.date.toString().toLowerCase());
              });
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: invoices.length,
                itemBuilder: (context, index) {
                  return orderItem(invoices, index);
                },
              );
            } else
              return Text('No Date');
          })
    ]));
  }
}
