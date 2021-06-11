import 'package:flutter/material.dart';

push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace)
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  else
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

pushNamed(BuildContext context, String route, {bool replace = false}) {
  if (replace)
    Navigator.pushReplacementNamed(context, route);
  else
    Navigator.pushNamed(context, route);
}

popUntil(BuildContext context, String route) =>
    Navigator.popUntil(context, ModalRoute.withName(route));

pop(BuildContext context, [result]) => Navigator.pop(context, result);

