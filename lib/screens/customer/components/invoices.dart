import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';

// ignore: must_be_immutable
class Invoices extends StatefulWidget {
  Customer customer;
  List<PubgUc> invoices;
  @override
  _InvoicesState createState() => _InvoicesState(customer, invoices);
  Invoices(this.customer, this.invoices);
}

class _InvoicesState extends State<Invoices> {
  Customer customer;
  List<PubgUc> invoices;
  _InvoicesState(this.customer, this.invoices);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width * 0.42,
              child: Image.asset(
                'assets/images/paint.png',
                color: Colors.black,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  'Invoices',
                  style: GoogleFonts.viaodaLibre(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            if (invoices.isEmpty) {
              return Text('no invoices');
            } else {
              DateTime now = DateTime.parse(invoices[index].date);

              return Container(
                child: Container(
                  height: 73,
                  child: ListTile(
                    focusColor: Colors.white,
                    title: Text(invoices[index].name),
                    subtitle: Text('${invoices[index].price}'),
                    trailing: Text(
                        '${now.year}-${now.month}-${now.day}  ${now.hour}:${now.minute}'),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
