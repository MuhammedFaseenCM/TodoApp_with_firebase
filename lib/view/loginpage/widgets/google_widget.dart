import 'package:flutter/material.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/string_consts.dart';

class SignInContainer extends StatelessWidget {
  const SignInContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
          color:kwhiteColor,
          boxShadow: [
            BoxShadow(
              color: kblackColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes the position of the shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20.0)),
      child: Image.asset(googleIcon),
    );
  }
}
