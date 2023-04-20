import 'package:flutter/material.dart';
import 'package:todo/controller/signup/signup_function.dart';
import 'package:todo/model/signup/signup_model.dart';
import 'package:todo/view/core/button_widget.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/string_consts.dart';
import 'package:todo/view/core/widgets.dart';
import 'package:todo/view/loginpage/widgets/fields.dart/email_field.dart';
import 'package:todo/view/loginpage/widgets/fields.dart/password_field.dart';

import 'package:todo/view/loginpage/sections/header_section.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static final SignupModel signupmodel = SignupModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange[900]!,
              Colors.orange[800]!,
              Colors.orange[400]!,
            ],
          ),
        ),
        child: Column(
          children: [
            HeaderSection(
              title: signupText.toUpperCase(),
              subtitle: welcomText,
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                      key: signupmodel.signupformKey,
                      child: Column(
                        children: [
                          kheight20,
                          TextFormField(
                            controller: signupmodel.fullnameController,
                            decoration: const InputDecoration(
                              label: Text(fullnameText),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person,
                                size: 20.0,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return validNameText;
                              }
                              return null;
                            },
                          ),
                          kheight20,
                          EmailField(
                              emailController: signupmodel.emailController),
                          kheight20,
                          PasswordField(
                              passwordController:
                                  signupmodel.passwordController),
                          kheight20,
                          PasswordField(
                            passwordController:
                                signupmodel.confirmpasswordController,
                            isConfirm: true,
                            confirmPassword: signupmodel.passwordController,
                          ),
                          kheight20,
                          ButtonWidget(
                            text: "Verify",
                            color: kOrange900,
                            onpressed: (context) async {
                              final isValid = signupmodel
                                  .signupformKey.currentState!
                                  .validate();
                              if (!isValid) return;

                              await signUp(
                                  context: context,
                                  email:
                                      signupmodel.emailController.text.trim(),
                                  password: signupmodel.passwordController.text
                                      .trim());
                              // await userSignupDetailsToFireStore(
                              //     email:
                              //         signupmodel.emailController.text.trim(),
                              //     name: signupmodel.fullnameController.text
                              //         .trim(),
                              //     password: signupmodel.passwordController.text
                              //         .trim(),
                              //     phoneNumber:
                              //         signupmodel.numberController.text.trim(),
                              //     context: context);
                              // signupmodel.fullnameController.clear();
                              // signupmodel.emailController.clear();
                              // signupmodel.passwordController.clear();
                              // signupmodel.confirmpasswordController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
