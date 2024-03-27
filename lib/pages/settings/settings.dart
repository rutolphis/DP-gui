import 'package:flutter/material.dart';
import 'package:gui_flutter/pages/settings/widgets/emergency_contact.dart';
import 'package:gui_flutter/pages/settings/widgets/emergency_contacts.dart';
import 'package:gui_flutter/pages/settings/widgets/settings_container.dart';
import 'package:gui_flutter/widgets/page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(
        title: "Settings",
        body: Column(
          children: [
            EmergencyContactsWidget()
          ],
        ));
  }
}
