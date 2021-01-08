import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/about/about_screen.dart';
import 'package:plant_app/screens/notes/notes_screen.dart';
import 'package:plant_app/screens/statistics/statistics_screen.dart';
import 'package:plant_app/constants.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: size.height,
            color: kPrimaryColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      width: size.width,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52.0,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "تقييد",
                            style: GoogleFonts.cairo(
                                fontSize: 35, color: Colors.white70),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "كلو مقيد بالدفتر",
                            style: GoogleFonts.cairo(
                                fontSize: 18, color: Colors.white38),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[900],
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotesScreen()));
                        },
                        leading: Icon(
                          Icons.notes_sharp,
                          color: Colors.black,
                        ),
                        title: Text("Notes"),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatisticsScreen()));
                        },
                        leading: Icon(
                          Icons.bar_chart,
                          color: Colors.black,
                        ),
                        title: Text("Stats"),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboutScreen(),
                              ));
                        },
                        leading: Icon(
                          Icons.info,
                          color: Colors.black,
                        ),
                        title: Text("About"),
                      )),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    '© 2021 MohammadSaleh. All Rights Reserved.',
                    style: TextStyle(
                        fontFamily: '',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]),
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
