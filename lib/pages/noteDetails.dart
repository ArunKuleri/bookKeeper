import 'package:flutter/material.dart';
import 'package:notekeeper/pages/notes.dart';

class NoteDetails extends StatefulWidget {
  String appBarTitle;
  NoteDetails(this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState(this.appBarTitle);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priorities = ["High", "Low"];
  String appBarTitle;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  NoteDetailsState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    debugPrint("user selected $valueSelectedByUser");
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint("something changed in title text text  Fiels");
                },
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint(
                      "something changed in Description text text  Fiels");
                },
                decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Delete",
                      textScaleFactor: 1.5,
                    ),
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Share",
                      textScaleFactor: 1.5,
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
