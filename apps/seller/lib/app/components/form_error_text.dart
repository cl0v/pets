import 'package:flutter/material.dart';

import 'package:seller/constants.dart';

class FormErrorText extends StatelessWidget {
  final String? errorMsg;
  const FormErrorText(
    this.errorMsg,
  );
  @override
  Widget build(BuildContext context) {
    return errorMsg != null ? Text(
      errorMsg ?? 'Ocorreu um error',
      style: kErrorTextStyle,
    ) : Container();
  }
}
