import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class ConnectButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ConnectButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorConstants.primary, // Set your desired button color here
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Use min to wrap content size
          children: [
            Icon(IconData(0xe0e4, fontFamily: 'MaterialIcons'),size: 30, color: Colors.white, weight: 300,), // Icon color
            SizedBox(width: 10.0), // Space between icon and text
            Text("Connect watch", style: TextStylesConstants.bodyLarge.copyWith(color: Colors.white)), // Text style
          ],
        ),
      ),
    );
  }
}
