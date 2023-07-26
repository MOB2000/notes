import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants.dart';
import 'package:notes/db_helper/db_helper.dart';
import 'package:notes/models/notes.dart';
import 'package:notes/widgets/color_picker.dart';
import 'package:notes/widgets/priority_picker.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  const NoteDetail(this.note, this.appBarTitle, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState();
  }
}

class NoteDetailState extends State<NoteDetail> {
  final helper = DatabaseHelper();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late int color;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description ?? '';
    color = widget.note.color;
    return WillPopScope(
      onWillPop: () async {
        isEdited ? showDiscardDialog(context) : moveToLastScreen();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.appBarTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: kColors[color],
          leading: IconButton(
              splashRadius: 22,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                isEdited ? showDiscardDialog(context) : moveToLastScreen();
              }),
          actions: <Widget>[
            IconButton(
              splashRadius: 22,
              icon: const Icon(
                Icons.save,
                color: Colors.black,
              ),
              onPressed: () {
                titleController.text.isEmpty
                    ? showEmptyTitleDialog(context)
                    : _save();
              },
            ),
            IconButton(
              splashRadius: 22,
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                showDeleteDialog(context);
              },
            )
          ],
        ),
        body: Container(
          color: kColors[color],
          child: Column(
            children: <Widget>[
              PriorityPicker(
                selectedIndex: 3 - widget.note.priority,
                onTap: (index) {
                  isEdited = true;
                  widget.note.priority = 3 - index;
                },
              ),
              ColorPicker(
                selectedIndex: widget.note.color,
                onTap: (index) {
                  setState(() {
                    color = index;
                  });
                  isEdited = true;
                  widget.note.color = index;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: titleController,
                  maxLength: 255,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: (value) {
                    updateTitle();
                  },
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Title',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    maxLength: 255,
                    controller: descriptionController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Description',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text(
            "Discard Changes?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Text(
            "Are you sure you want to discard changes?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                moveToLastScreen();
              },
            ),
          ],
        );
      },
    );
  }

  void showEmptyTitleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text(
            "Title is empty!",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Text(
            'The title of the note cannot be empty.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Okay",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.purple,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: Text(
            "Delete Note?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Text(
            "Are you sure you want to delete this note?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.purple),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _delete();
              },
            ),
          ],
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    isEdited = true;
    widget.note.title = titleController.text;
  }

  void updateDescription() {
    isEdited = true;
    widget.note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    widget.note.date = DateFormat.yMMMd().format(DateTime.now());

    if (widget.note.id != null) {
      await helper.updateNote(widget.note);
    } else {
      await helper.insertNote(widget.note);
    }
  }

  void _delete() async {
    await helper.deleteNote(widget.note.id);
    moveToLastScreen();
  }
}
