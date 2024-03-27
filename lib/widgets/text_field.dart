import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final BorderRadius borderRadius;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  CustomTextFieldWidget({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStylesConstants.bodyBase,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 1, color: ColorConstants.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(width: 2, color: ColorConstants.primary),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
    );
  }
}
