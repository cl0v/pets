import 'package:flutter/material.dart';

import '../../constants.dart';

AppBar customAppBar(String title, {bool? automaticallyImplyLeading}) {
  return AppBar(
    brightness: Brightness.light,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: automaticallyImplyLeading ?? false,
    title: Text(
      title,
      style: kTitleTextStyle,
    ),
  );
}
