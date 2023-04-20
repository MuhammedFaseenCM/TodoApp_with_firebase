import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/signup/signup_model.dart';

import 'package:todo/view/core/string_consts.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController? confirmPassword;
  final bool? isConfirm;
  const PasswordField(
      {super.key,
      required this.passwordController,
      this.isConfirm = false,
      this.confirmPassword});
  //static final SignupModel signupModel = SignupModel();
  @override
  Widget build(BuildContext context) {
    //  return Observer(builder: (_) {
    return Consumer<SignupModel>(
        builder: (context, signupModel, _) => TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  label: const Text(passwordText),
                  border: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: signupModel.toggleObscureText,
                    child: signupModel.obscureText
                        ? const Icon(
                            Icons.visibility_off,
                          )
                        : const Icon(Icons.visibility),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 20.0,
                  )),
              obscureText: signupModel.obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validPassowrdText;
                } else if (value.length < 6) {
                  return validcharPasswordText;
                }
                if (isConfirm == true && confirmPassword!.text != value) {
                  return validMatchPassText;
                }
                return null;
              },
            ));
    // });
  }
}
