import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class SettingsContainerWidget extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets? padding;
  final VoidCallback? onIconTap;

  const SettingsContainerWidget(
      {Key? key, required this.child, this.title, this.padding, this.onIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorConstants.white,
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
          title != null
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: TextStylesConstants.h2
                          .copyWith(color: const Color(0xff878C99)),
                    ),
                    if (onIconTap != null)
                      ElevatedButton(
                        onPressed: () => onIconTap!(),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor:
                              ColorConstants.fifth, // <-- Button color
                          foregroundColor: Colors.red, // <-- Splash color
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          width: 24,
                          height: 24,
                        ),
                      )
                  ],
                )
              : Container(),
          const SizedBox(
            height: 32,
          ),
          child
        ],
      ),
      // Specify the container size, child, or other properties here
    );
  }
}
