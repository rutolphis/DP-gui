import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/fonts.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final Widget icon;
  final String text;

  const CustomButton(
      {Key? key,
      required this.onTap,
      this.padding,
      required this.icon,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorConstants.primary, // Set your desired button color here
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Use min to wrap content size
          children: [
            icon,
            const SizedBox(width: 10.0), // Space between icon and text
            Text(text,
                style: TextStylesConstants.bodyLarge
                    .copyWith(color: Colors.white)), // Text style
          ],
        ),
      ),
    );
  }
}
