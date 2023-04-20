import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/model/signup/user_model.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/utils.dart';

Future<void> signUp(
    {required context, required email, required password}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    Utils.showSnackBar(
      context,
      
      e.message,
      color: Colors.red[900],
      textColor: kwhiteColor,
    );
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}

Future<void> userSignupDetailsToFireStore(
    {required name,
    required email,
    required phoneNumber,
    required password,
    required context}) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  final docUser = FirebaseFirestore.instance.collection("Users").doc(email);

  CreateUser createUser = CreateUser(
    name: name,
    email: email,
    password: password,
  );

  Map<String, dynamic> userDataToSend = createUser.toMap();
  await docUser.set(userDataToSend);

  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
