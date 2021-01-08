import 'package:flutter/material.dart';
import 'package:plant_app/screens/drawer/drawer_screen.dart';
import '../../constants.dart';
import 'components/body.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: generalAppBar("Notes", size.width, context, Colors.yellow[900]),
      body: Body(),
    );
  }
}
