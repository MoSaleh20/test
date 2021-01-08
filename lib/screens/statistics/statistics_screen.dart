import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/body.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: generalAppBar("Stats", size.width, context, Colors.blueGrey[600]),
      body: Body(),
    );
  }
}
