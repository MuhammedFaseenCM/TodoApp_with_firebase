import 'package:flutter/material.dart';
import 'package:todo/view/core/const_colors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, context,
      {color, textColor, snackPosition}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kredColor,
        content: Text(
          text!,
          style:
              const TextStyle(color: kwhiteColor, fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
