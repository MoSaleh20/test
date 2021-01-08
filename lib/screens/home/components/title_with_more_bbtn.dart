import 'package:flutter/material.dart';

import '../../../constants.dart';

class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
    this.text,
  }) : super(key: key);
  final String title;
  final Function press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.transparent,
                onPressed: press,
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
