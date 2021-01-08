import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/payment.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/screens/customer/components/invoices.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  Customer customer;

  Body(this.customer);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: FutureBuilder(
          future: DatabaseProvider.db.payment,
          builder: (context, snapshot) {
            List<Payment> payments = [];
            payments = snapshot.data;
            if (!snapshot.hasData)
              return Container(
                margin: EdgeInsets.all(20),
                child: Text('no Data!'),
              );
            else {
              List<Payment> thisCustPayments = [];
              for (var i = 0; i < payments.length; i++) {
                if (payments[i].customerName == widget.customer.name) {
                  thisCustPayments.add(payments[i]);
                }
              }
              return SingleChildScrollView(
                child: FutureBuilder(
                  future: DatabaseProvider.db.orders,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('no data');
                    } else {}
                    return FutureBuilder(
                      future: DatabaseProvider.db.orders,
                      builder: (context, snapshot) {
                        List<PubgUc> invoices = [];
                        invoices = snapshot.data;
                        if (snapshot.hasData) {
                          List<PubgUc> thisCustInvoices = [];
                          for (var i = 0; i < invoices.length; i++) {
                            if (invoices[i].customerName ==
                                widget.customer.name) {
                              thisCustInvoices.add(invoices[i]);
                            }
                          }
                          Customer tempCust = widget.customer;
                          tempCust.dept =
                              widget.customer.balance - widget.customer.payment;
                          DatabaseProvider.db.updateCustomer(tempCust);
                          int count = 0;
                          if (invoices.length > payments.length)
                            count = invoices.length;
                          else
                            count = payments.length;
                          return SingleChildScrollView(
                              child: Column(children: <Widget>[
                            header(
                              widget.customer,
                            ),
                            Container(
                                width: size.width,
                                height: 73.0 * count,
                                constraints: BoxConstraints(
                                    minHeight: size.height,
                                    maxHeight: double.infinity),
                                child: PageView(
                                  children: [
                                    Invoices(widget.customer, thisCustInvoices),
                                    paymentsPage(
                                        widget.customer, thisCustPayments),
                                  ],
                                ))
                          ]));
                        } else
                          return Container(
                              child: Text('No data!'),
                              padding: EdgeInsets.all(10));
                      },
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  header(customer) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.35,
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                height: size.height,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/profile.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          Text(
                            customer.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Image.asset(
                                "assets/images/whatsapp.png",
                                scale: 1,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.only(right: 20),
                              onPressed: () async {
                                if (customer.phone != null) {
                                  String message = "";
                                  var url =
                                      "whatsapp://send?phone=${customer.phone}&text=${Uri.parse(message)}";
                                  if (await canLaunch(url))
                                    await launch(url);
                                  else
                                    throw "There is an issue, try again later!";
                                } else
                                  Toast.show(
                                      "Can't dial this customer!", context);
                              }),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                          children: [
                            Info(customer.balance, "Balance"),
                            Info(customer.dept, "Dept"),
                            Info(customer.payment, "Payments"),
                            Container(
                              margin: EdgeInsets.only(right: size.width * 0.1),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showDialog(context, customer);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, customer) {
    TextEditingController paymentController = TextEditingController();
    contentBox(context) {
      return SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  top: 20 + kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  boxShadow: [
                    BoxShadow(
                        color: kPrimaryColor,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Insert a new Payment",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      controller: paymentController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r"^\-?\d*\.?\d*")),
                      ],
                      decoration: InputDecoration(
                          icon: Icon(Icons.label), hintText: "Payment")),
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        double temp = customer.payment +
                            double.parse(paymentController.text);
                        // DatabaseProvider.db.updateCustomer(Customer(
                        //   id: customer.id,
                        //   name: customer.name,
                        //   balance: customer.balance,
                        //   payment: customer.payment +
                        //       double.parse(paymentController.text),
                        //   dept: customer.balance -
                        //       customer.payment -
                        //       double.parse(paymentController.text),
                        //   inDept: inDept,
                        // ));
                        DateTime now = DateTime.now();
                        DatabaseProvider.db.insertPayment(Payment(
                          amount: double.parse(paymentController.text),
                          date: now.toString(),
                          customerName: customer.name,
                        ));
                        Customer tempCust = customer;
                        tempCust.payment +=
                            double.parse(paymentController.text);
                        tempCust.dept = tempCust.balance - tempCust.payment;
                        DatabaseProvider.db.updateCustomer(tempCust);
                        setState(() {});
                        Navigator.of(context).pop();
                        Toast.show("Payment added", context, duration: 3);
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: kDefaultPadding,
              right: kDefaultPadding,
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: 30,
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(kDefaultPadding)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    )),
              ),
            ),
          ],
        ),
      );
    }

    showDialog(
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultPadding),
            ),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            child: contentBox(context),
          );
        },
        context: context);
  }

  paymentsPage(customer, payments) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width * 0.44,
              child: Image.asset(
                'assets/images/paint.png',
                color: Colors.black,
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Payments',
                  style: GoogleFonts.viaodaLibre(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: payments.length,
          itemBuilder: (context, index) {
            if (payments.isEmpty) {
              return Text('no invoices');
            } else {
              payments.sort((a, b) {
                return b.date
                    .toString()
                    .toLowerCase()
                    .compareTo(a.date.toString().toLowerCase());
              });
              DateTime now = DateTime.parse(payments[index].date);

              return Container(
                child: Container(
                  height: 73.0,
                  child: ListTile(
                    focusColor: Colors.white,
                    title: Text("${payments[index].amount}"),
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

class Info extends StatelessWidget {
  final double amount;
  final String text;
  Info(this.amount, this.text);
  Color color() {
    if (text == "Dept") {
      if (amount > 0)
        return Colors.redAccent;
      else
        return Colors.white;
    } else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              text,
              textScaleFactor: 0.9,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "$amount",
              textScaleFactor: 1.3,
              style: TextStyle(color: color(), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
