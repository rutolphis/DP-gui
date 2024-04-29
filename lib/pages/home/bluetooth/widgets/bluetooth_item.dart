import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

class BluetoothItemWidget extends StatelessWidget {
  final String name;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;  // Callback for tap action

  const BluetoothItemWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.isSelected,
    required this.onTap,  // Include onTap in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // Use the passed callback here
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
        decoration: BoxDecoration(
          color: ColorConstants.secondary,
          borderRadius: BorderRadius.circular(8.0),
          border: isSelected ? Border.all(
            color: ColorConstants.primary,
            width: 8.0,
          ) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/house.svg',
                  color: ColorConstants.grey,
                ),
                const SizedBox(width: 10,),
                Text(
                  name,
                  style: TextStylesConstants.bodyLarge.copyWith(color: ColorConstants.grey,),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/watch.svg',
                  color: ColorConstants.grey,
                ),
                const SizedBox(width: 10,),
                Flexible(
                  child: Text(
                    address,
                    style: TextStylesConstants.bodyLarge.copyWith(color: ColorConstants.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
