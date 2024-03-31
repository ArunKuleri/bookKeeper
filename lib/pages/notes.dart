import 'package:flutter/material.dart';
import 'package:notekeeper/moels/note.dart';
import 'package:notekeeper/pages/noteDetails.dart';
import 'package:notekeeper/utlis/databaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note(2, "", "", 4, ''), "Add Notes");
        },
        tooltip: "add notes",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle? titlestyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                "Dummy title ",
                style: titlestyle,
              ),
              subtitle: Text(this.noteList[position].title),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _delete(context, noteList[position]);
                },
              ),
              onTap: () {
                debugPrint("");
                navigateToDetail(this.noteList[position], "Edit note");
              },
            ),
          );
        });
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);

      case 2:
        return Icon(Icons.keyboard_arrow_right);

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void navigateToDetail(Note note, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(note, title);
    }));
  }

  void updateListView() {
    final Future dbFuture = databaseHelper.intializeDatabase();
    dbFuture.then((noteList) {
      setState(() {
        this.noteList = noteList;
        this.count = noteList.length;
      });
    });
  }
}
