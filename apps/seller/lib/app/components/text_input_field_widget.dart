import 'package:flutter/material.dart';

class TextInputFieldWidget extends StatelessWidget {
  const TextInputFieldWidget({
    required this.hint,
    required this.controller,
    this.prefixWidget,
    this.icon,
    this.padding,
    this.isObscure = false,
    this.inputType,
    this.inputAction,
  });

  final IconData? icon;
  final String hint;
  final bool isObscure;
  final TextEditingController controller;
  final Widget? prefixWidget;
  final EdgeInsetsGeometry? padding;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: TextFormField(
              controller: controller,
              obscureText: isObscure,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 6),
                  child: prefixWidget ??
                      Icon(
                        icon,
                        size: 24,
                      ),
                ),
                hintText: hint,
              ),
              keyboardType: inputType,
              textInputAction: inputAction,
            ),
          ),
        ),
      ),
    );
  }
}
