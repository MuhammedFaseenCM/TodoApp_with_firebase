import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo/main.dart';
import 'package:todo/view/core/utils.dart';

Future signIn(
    {required context,
    required TextEditingController email,
    required TextEditingController password}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) async => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signed in as ${email.text}'),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              ),
              email.clear(),
              password.clear()
            });
  } on FirebaseAuthException catch (e) {
    Utils.showSnackBar(e.toString(), context);
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
