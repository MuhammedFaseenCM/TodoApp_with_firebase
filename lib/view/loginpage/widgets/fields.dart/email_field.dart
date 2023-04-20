import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/core/string_consts.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});
  // static final LoginModel loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        label: Text(mailText),
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.mail,
          size: 20.0,
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value != null && !EmailValidator.validate(value)) {
          return validEmailText;
        } else {
          return null;
        }
      },
    );
  }
}
