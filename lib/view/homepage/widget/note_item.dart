import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/note_model/note_model.dart';
import 'package:todo/view/addscreen/screen_add_note.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/string_consts.dart';

class TodoItem extends StatelessWidget {
  final String docId;
  final NoteModel noteModel;
  const TodoItem({super.key, required this.docId, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ScreenAddNote(
              type: ActionType.editNote,
              docId: docId,
              noteModel: noteModel,
            );
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  noteModel.title ?? "No title",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                Column(
                  children: [
                    Checkbox(
                      value: noteModel.iscompleted,
                      onChanged: (value) {
                        final docUser = FirebaseFirestore.instance
                            .collection(FirebaseAuth.instance.currentUser!.email
                                .toString())
                            .doc(docId);

                        docUser.update({'isCompleted': value});
                      },
                      activeColor: kOrange900,
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text(warningText),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        final query = FirebaseFirestore.instance
                                            .collection(FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString());

                                        query.doc(docId).delete();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(confirmText)),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(cancelText))
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
            Text(
              noteModel.content ?? "No content",
              maxLines: 5,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}
