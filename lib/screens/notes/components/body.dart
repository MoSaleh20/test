import 'package:flutter/material.dart';
import 'package:plant_app/components/note.dart';
import 'package:plant_app/databaseProvider.dart';

class Body extends StatelessWidget {
  List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseProvider.db.note,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Text('no Data!'),
            );
          } else {
            notes = snapshot.data;
            notes.sort((a, b) {
              return b.date
                  .toString()
                  .toLowerCase()
                  .compareTo(a.date.toString().toLowerCase());
            });
            return SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    DateTime tempDate = DateTime.parse(notes[index].date);
                    String now =
                        "${tempDate.year}-${tempDate.month}-${tempDate.day}  ${tempDate.hour}:${tempDate.minute}";
                    return ListTile(
                      title: Text("${notes[index].body}"),
                      trailing: Text("$now"),
                    );
                  }),
            );
          }
        });
  }
}
