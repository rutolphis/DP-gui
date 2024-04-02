import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/pages/settings/widgets/personal_information_dialog.dart';
import 'package:gui_flutter/pages/settings/widgets/personal_information_item.dart';
import 'package:gui_flutter/pages/settings/widgets/settings_container.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  Widget _Divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        height: 2,
        color: ColorConstants.secondary,
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PersonalInformationDialog(
            title: 'Edit personal information',
            onSubmit: (String name, String phone, String address,
                String bloodGroup, String insuranceCompany) {},
            submit: 'Save changes',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsContainerWidget(
        title: "Personal information",
        onIconTap: () => _showDialog(),
        child: Column(
          children: [
            PersonalInfromationItemWidget(
              itemName: "Name",
              itemValue: "kokot",
            ),
            _Divider(),
            PersonalInfromationItemWidget(
              itemName: "Name",
              itemValue: "kokot",
            ),
            _Divider(),
            PersonalInfromationItemWidget(
              itemName: "Name",
              itemValue: "kokot",
            ),
            _Divider(),
            PersonalInfromationItemWidget(
              itemName: "Name",
              itemValue: "kokot",
            )
          ],
        ));
  }
}
