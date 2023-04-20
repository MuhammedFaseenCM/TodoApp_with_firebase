import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/note_model/note_model.dart';
import 'package:todo/view/core/appbar_widget.dart';
import 'package:todo/view/homepage/main_screen.dart';

enum ActionType { addNote, editNote }

class ScreenAddNote extends StatelessWidget {
  final ActionType type;
  final String? docId;
  final NoteModel? noteModel;
  ScreenAddNote({super.key, required this.type, this.docId, this.noteModel});

  Widget saveButton({required context}) => TextButton.icon(
      onPressed: () async {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;

        switch (type) {
          case ActionType.addNote:
            await saveNote(context: context);

            break;
          case ActionType.editNote:
            saveEditedNote(context: context);

            break;
        }
      },
      icon: const Icon(
        Icons.save,
        color: Colors.black,
      ),
      label: const Text(
        'Save',
        style: TextStyle(color: Colors.black),
      ));

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      if (docId == null) {
        Navigator.of(context).pop();
      } else {
        if (noteModel == null) {
          Navigator.of(context).pop();
        } else {
          titleController.text = noteModel!.title ?? 'No title';
          contentController.text = noteModel!.content ?? 'No content';
        }
      }
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarWidget(
            title: type == ActionType.addNote ? 'Add note' : "Edit note",
            actions: [saveButton(context: context)],
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the title";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: contentController,
                maxLines: 4,
                maxLength: 100,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the content";
                  } else {
                    return null;
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> saveNote({required context}) async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    final newNote = NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      iscompleted: false,
    ).toMap();

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final docUser = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc();

      docUser
          .set(newNote)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
              (route) => false));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveEditedNote({required context}) async {
    final title = titleController.text;
    final content = contentController.text;

    final editNote = NoteModel(
            id: noteModel!.id,
            title: title,
            content: content,
            iscompleted: noteModel!.iscompleted)
        .toMap();
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final docUser = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .doc(docId);

      docUser
          .set(editNote)
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
              (route) => false));
    } catch (e) {
      log(e.toString());
    }
  }
}
