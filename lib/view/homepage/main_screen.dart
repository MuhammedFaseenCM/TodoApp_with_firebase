import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/model/note_model/note_model.dart';
import 'package:todo/view/addscreen/screen_add_note.dart';
import 'package:todo/view/core/appbar_widget.dart';
import 'package:todo/view/homepage/widget/note_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
          title: "Home",
          actions: [
            IconButton(
                onPressed: () {
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth.instance.signOut();
                  googleSignIn.signOut();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseAuth.instance.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.hasData) {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
                  List<Map<String, dynamic>> items = documents
                      .map((e) => e.data() as Map<String, dynamic>)
                      .toList();

                  if (items.isEmpty) {
                    return const Center(
                      child: Text("No notes yet",
                          style: TextStyle(
                            fontSize: 20.0,
                          )),
                    );
                  }
                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(20),
                    children: List.generate(items.length, (index) {
                      final notes = NoteModel.fromJson(items[index]);

                      return TodoItem(
                        docId: documents[index].id,
                        noteModel: notes,
                      );
                    }),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ScreenAddNote(
                type: ActionType.addNote,
              );
            },
          ));
        },
        label: const Text('New'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
