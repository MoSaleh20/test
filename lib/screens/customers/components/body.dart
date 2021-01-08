import 'package:flutter/material.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/screens/customer/customer_screen.dart';
import '../../../databaseProvider.dart';
import 'package:plant_app/constants.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Customer> customers = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder(
          future: DatabaseProvider.db.custs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              customers = snapshot.data;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerScreen(customers[index]),
                          ));
                    },
                    child: Container(
                      child: ListTile(
                          tileColor: alertColor(customers[index]),
                          focusColor: Colors.transparent,
                          title: Row(children: [
                            alertIcon(customers[index]),
                            SizedBox(
                              width: 5,
                            ),
                            Text(customers[index].name),
                          ]),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '₪ ${customers[index].dept}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          trailing: deleteIcon(index)),
                    ),
                  );
                },
              );
            } else
              return Text('No Data');
          })
    ]));
  }

  Widget deleteIcon(index) {
    if (customers[index].name != "unknown")
      return GestureDetector(
        onTap: () {
          deleteDialog(context, index);
        },
        child: Icon(Icons.delete_sweep),
      );
  }

  Icon alertIcon(customer) {
    if (customer.dept > 0) {
      return Icon(
        Icons.dangerous,
        color: Colors.black,
      );
    } else
      return Icon(
        Icons.check_circle_rounded,
        color: Colors.green[600],
      );
  }

  Color alertColor(customer) {
    if (customer.dept > 0) {
      return Colors.red[400];
    } else
      return Colors.white;
  }

  deleteDialog(context, index) {
    showDialog(
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          elevation: 0,
          backgroundColor: Colors.red[600],
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
                      height: 160,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Deletion can't be undone.",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 11),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                              onPressed: () {
                                Toast.show(
                                    "This customer can't be deleted!", context,
                                    backgroundColor: Colors.redAccent);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.red[600], fontSize: 18),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kDefaultPadding,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultPadding)),
                      child: Image.asset(
                        'assets/images/deleteGIF.gif',
                        scale: 1,
                      )),
                ),
              ),
            ],
          ),
        );
      },
      context: context,
    );
  }
}
