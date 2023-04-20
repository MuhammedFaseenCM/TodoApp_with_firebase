import 'package:flutter/material.dart';

class SignupModel extends ChangeNotifier {
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  GlobalKey<FormState> signupformKey = GlobalKey<FormState>();

  TextEditingController get passwordController => signuppasswordController;

  set passwordController(TextEditingController value) {
    signuppasswordController = value;
    notifyListeners();
  }

  TextEditingController get emailController => signupemailController;

  set emailController(TextEditingController value) {
    signupemailController = value;
    notifyListeners();
  }
}
