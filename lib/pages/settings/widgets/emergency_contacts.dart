import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/pages/settings/widgets/settings_container.dart';

import 'emergency_contact.dart';
import 'emergency_contact_dialog.dart';

class EmergencyContactsWidget extends StatefulWidget {
  const EmergencyContactsWidget({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsWidget> createState() =>
      _EmergencyContactsWidgetState();
}

class _EmergencyContactsWidgetState extends State<EmergencyContactsWidget> {
  List<Contact> list1 = [];
  List<Contact> list2 = [];

  void distributeContacts(List<Contact> contacts) {
    // Initialize two lists to hold the distributed contacts
    List<Contact> list1 = [];
    List<Contact> list2 = [];

    // Iterate through the contacts and distribute them
    for (int i = 0; i < contacts.length; i++) {
      if (i % 2 == 0) {
        list1.add(contacts[i]);
      } else {
        list2.add(contacts[i]);
      }
    }

    // For demonstration, print out the contents of the lists
    print("List 1:");
    list1.forEach((contact) => print("${contact.name} - ${contact.phone}"));

    print("List 2:");
    list2.forEach((contact) => print("${contact.name} - ${contact.phone}"));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyContactDialog(title: 'Add Emergency Contact', onSubmit: (String name, String phone) {  }, submit: 'Add Emergency Contact',);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SettingsContainerWidget(
        title: "Emergency contacts",
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EmergencyContactWidget(
                        text1: "Mom",
                        text2: "0910823367", onEdit: () {  }, onDelete: () {  },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EmergencyContactWidget(
                        text1: "Dad",
                        text2: "0910823367", onEdit: () {  }, onDelete: () {  },
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: const EdgeInsets.all(2),
                  constraints: const BoxConstraints(),
                  onPressed: () => _showDialog(context),
                  icon: SvgPicture.asset('assets/icons/add.svg'),
                  iconSize: 70,
                ))
          ],
        ));
  }
}
