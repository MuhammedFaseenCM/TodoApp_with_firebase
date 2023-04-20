import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/core/string_consts.dart';
import 'package:todo/view/loginpage/login_screen.dart';
import 'package:todo/view/signuppage/widget/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(wrongText),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const LoginPage();
            //AuthPage();
          }
        },
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
