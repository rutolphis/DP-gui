import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/pages/settings/widgets/emergency_contacts/emergency_contact_dialog.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class EmergencyContactWidget extends StatelessWidget {
  final String name;
  final String phone;
  final int contactIndex;

  const EmergencyContactWidget({
    Key? key,
    required this.name,
    required this.phone, required this.contactIndex,
  }) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyContactDialog(title: 'Edit Emergency Contact', name: name , phone: phone, submit: 'Save changes', contactIndex: contactIndex,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: ColorConstants.secondary,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () => _showDialog(context),
              child: SvgPicture.asset(
                'assets/icons/edit.svg',
                width: 24,
                height: 24,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: ColorConstants.fifth, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/person.svg',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 16),
                    Text(
                      name,
                      style: TextStylesConstants.bodyLarge
                          .copyWith(color: const Color(0xff878C99)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/phone.svg',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 16),
                    Text(
                      phone,
                      style: TextStylesConstants.bodyLarge
                          .copyWith(color: const Color(0xff878C99)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
