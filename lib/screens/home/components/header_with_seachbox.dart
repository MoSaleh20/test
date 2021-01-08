import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/note.dart';
import 'package:plant_app/databaseProvider.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.3 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.contain),
                  ),
                ),
                Spacer(),
                Text(
                  "تقييد",
                  style: GoogleFonts.cairo(fontSize: 50, color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: noteController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        icon: IconButton(
                          icon: Icon(
                            Icons.note_add,
                            color: Colors.blue[600],
                          ),
                          onPressed: () {
                            DateTime now = DateTime.now();
                            Note note =
                                Note(body: noteController.text, date: "$now");
                            DatabaseProvider.db.insertNote(note);
                            noteController.clear();
                            Toast.show("Note Added!", context, gravity: 20);
                          },
                        ),
                        hintText: "Add Note...",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class Search extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
