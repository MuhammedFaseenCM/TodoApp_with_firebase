import 'package:flutter/material.dart';
import 'package:todo/controller/signin/login_functions.dart';
import 'package:todo/controller/signin/signin_google.dart';
import 'package:todo/model/signup/signup_model.dart';

import 'package:todo/view/core/button_widget.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/string_consts.dart';
import 'package:todo/view/core/widgets.dart';

import 'package:todo/view/loginpage/widgets/fields.dart/email_field.dart';
import 'package:todo/view/loginpage/widgets/fields.dart/password_field.dart';

import 'package:todo/view/loginpage/widgets/google_widget.dart';
import 'package:todo/view/signuppage/signup_screen.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});
  static final loginFormKey = GlobalKey<FormState>();
  static final SignupModel signupModel = SignupModel();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: kwhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            topRight: Radius.circular(60.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EmailField(emailController: signupModel.emailController),
                kheight20,
                PasswordField(
                  passwordController: signupModel.passwordController,
                ),
                kheight20,
                kheight20,
                kheight20,
                ButtonWidget(
                  text: logintext,
                  onpressed: (context) {
                    final isValid = loginFormKey.currentState!.validate();
                    if (!isValid) return;
                    signIn(
                        context: context,
                        email: signupModel.emailController,
                        password: signupModel.passwordController);
                  },
                ),
                kheight20,
                const Text(signinWithText),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          siginInWithGoogle(context: context);
                        },
                        child: const SignInContainer())
                  ],
                ),
                kheight20,
                const Text(noAccountText),
                ButtonWidget(
                  text: signUpText,
                  onpressed: (context) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
