import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 50,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          SizedBox(
            height: size.height * 0.2,
          ),
          Container(
            width: size.width,
            color: Colors.transparent,
            margin: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'This app was built by Mohammad Saleh. in 2021.\nfor business inquiries please contact 16m.saleh@gmail.com',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
