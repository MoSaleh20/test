import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/screens/drawer/drawer_screen.dart';
import 'package:plant_app/screens/home/components/body.dart';
import 'package:plant_app/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: mainAppBar(context),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar mainAppBar(context) {
    return AppBar(
      primary: true,
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset("assets/icons/menu.svg"),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.info,
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
