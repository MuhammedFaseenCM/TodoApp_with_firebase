import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/main.dart';

import 'package:todo/view/core/utils.dart';

siginInWithGoogle({
  required context,
}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final signin =
        await auth.signInWithCredential(credential).then((value) async => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signed in as ${auth.currentUser!.email}'),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              ),
            });
    Navigator.of(context).pop();
    return signin;
  } on Exception catch (e) {
    Utils.showSnackBar(context, e.toString());
    print(e.toString());
    Navigator.of(context).pop();
  }
}
