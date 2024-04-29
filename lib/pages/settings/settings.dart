import 'package:flutter/material.dart';
import 'package:gui_flutter/pages/settings/widgets/emergency_contacts/emergency_contact.dart';
import 'package:gui_flutter/pages/settings/widgets/emergency_contacts/emergency_contacts.dart';
import 'package:gui_flutter/pages/settings/widgets/personal_information/personal_information.dart';
import 'package:gui_flutter/widgets/page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageWidget(
        title: "Settings",
        body: Column(
          children: [
            EmergencyContactsWidget(),
            SizedBox(
              height: 36,
            ),
            PersonalInformationWidget()
          ],
        ));
  }
}
