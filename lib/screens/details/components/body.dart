import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:plant_app/constants.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:plant_app/screens/item%20history/itemHistory_screen.dart';
import 'dialog.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class Body extends StatefulWidget {
  Body(this.name);
  String name;

  @override
  _BodyState createState() => _BodyState(name);
}

class _BodyState extends State<Body> {
  _BodyState(this.name);
  List<Customer> custs;
  List<PubgUc> ucPacks;
  List<String> items = [];
  String dropDownValue;
  TextEditingController price = TextEditingController();

  String name;
  PubgUc pubg;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder(
        future: DatabaseProvider.db.packs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ucPacks = snapshot.data;
            for (var i = 0; i < ucPacks.length; i++) {
              if (name == ucPacks[i].name) {
                pubg = ucPacks[i];
              }
            }
            return Container(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.47,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          margin: EdgeInsets.only(top: 50, bottom: 25, left: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey[300]),
                          child: Center(
                            widthFactor: 1,
                            child: IconButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding * 1.7),
                              icon: SvgPicture.asset(
                                "assets/icons/back_arrow.svg",
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.45,
                          width: size.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(63),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 60,
                                color: kPrimaryColor.withOpacity(0.29),
                              ),
                            ],
                            color: kPrimaryColor,
                            image: DecorationImage(
                              alignment: Alignment.bottomLeft,
                              fit: BoxFit.contain,
                              image: AssetImage("assets/images/pubgman.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: size.height * 0.008),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.yellow[700], Colors.yellow[900]],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: size.height * 0.02,
                      top: size.height * 0.04,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      pubg.name,
                      style: TextStyle(
                        fontFamily: 'Pubg',
                        fontSize: 60,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 20,
                        bottom: size.height * 0.01,
                        top: size.height * 0.01),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "₪${pubg.cost}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Column(children: [
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: size.width / 2,
                          height: size.height * 0.09,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            color: kPrimaryColor,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return showOrderDialog(pubg.name, context);
                                  });
                            },
                            child: Text(
                              "Add Order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: size.width / 2,
                          height: size.height * 0.09,
                          child: FlatButton(
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemHistoryScreen(pubg.name),
                                  ));
                            },
                            child: Text(
                              "View History",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: size.width / 2,
                          height: size.height * 0.09,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            color: Colors.redAccent[400],
                            onPressed: () {
                              _deleteDialog();
                            },
                            child: Text(
                              "Delete Pack",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(),
                ],
              ),
            );
          } else
            return Container(
                padding: EdgeInsets.all(10),
                child: Text('Data not available!'));
        },
      ),
    );
  }

  _deleteDialog() {
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
                          color: Colors.black,
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
                                // DatabaseProvider
                                //     .db
                                //     .removePack(ucPacks[index].name);
                                Toast.show(
                                    'This Pack cannot be deleted!', context,
                                    backgroundColor: Colors.red[600],
                                    duration: 5);
                                Navigator.of(context).pop();

                                setState(() {});
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
