import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class PersonalInfromationItemWidget extends StatelessWidget {
  final String itemName;
  final String? itemValue;
  const PersonalInfromationItemWidget({Key? key, required this.itemName, this.itemValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName,
              style: TextStylesConstants.bodyLarge
                  .copyWith(color: const Color(0xff878C99)),
            ),
            Text(
              itemValue ?? "-",
              style: TextStylesConstants.bodyLarge.copyWith(
                color: const Color(0xff878C99), fontWeight: FontWeight.w200
              ),
            )
          ],
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
