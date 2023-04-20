import 'package:flutter/material.dart';
import 'package:todo/view/core/const_colors.dart';
import 'package:todo/view/core/widgets.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: kwhiteColor),
      backgroundColor: kwhiteColor,
      elevation: 0.0,
      flexibleSpace: const AppBarContainer(),
      title: Text(
        title,
        style: const TextStyle(color: kwhiteColor),
      ),
      actions: actions,
      centerTitle: true,
    );
  }
}
