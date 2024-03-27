import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class StatsItemWidget extends StatelessWidget {
  final String title;
  final String value;

  const StatsItemWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start of the column
      children: [
        Text(
          title,
          style: TextStylesConstants.bodyBase.copyWith(color: const Color(0xff878C99)),
        ),
        const SizedBox(height: 10.0), // Space between the title and value
        Text(
          value,
          style: TextStylesConstants.bodyLarge.copyWith(color: ColorConstants.primary),
        ),
      ],
    );
  }
}
