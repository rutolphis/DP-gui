import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class HomeContainerWidget extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets? padding;
  final double? height;

  const HomeContainerWidget(
      {Key? key, required this.child, this.title, this.padding, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstants.secondary,
        // Using the secondary color from the theme
        borderRadius: BorderRadius.circular(8),
        // 8 radius border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01), // 1% opacity
            blurRadius: 15,
            offset: const Offset(0, 38), // Y: 38
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // 5% opacity
            blurRadius: 13,
            offset: const Offset(0, 22), // Y: 22
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.09), // 9% opacity
            blurRadius: 10,
            offset: const Offset(0, 10), // Y: 10
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10), // 10% opacity
            blurRadius: 5,
            offset: const Offset(0, 2), // Y: 2
          ),
        ],
      ),
      child: Column(
        children: [
          if (title != null)
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title!,
                    style: TextStylesConstants.h2
                        .copyWith(color: const Color(0xff878C99)),
                  ),
                ),
          child
        ],
      ),
      // Specify the container size, child, or other properties here
    );
  }
}
