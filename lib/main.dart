import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/signup/signup_model.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/string_consts.dart';
import 'package:todo/view/homepage/main_screen.dart';
import 'package:todo/view/loginpage/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignupModel(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Todo app',
            theme: ThemeData(
              primaryColor: kOrange900,
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
                  return const MainScreen();
                } else {
                  return const LoginPage();
                  //AuthPage();
                }
              },
            ),
          );
        });
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
