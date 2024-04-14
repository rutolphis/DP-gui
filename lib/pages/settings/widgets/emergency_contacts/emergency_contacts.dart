import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/pages/settings/widgets/settings_container.dart';
import 'package:gui_flutter/widgets/button.dart';

import '../../../../bloc/emergency_contacts/emergency_contacts_event.dart';
import 'emergency_contact.dart';
import 'emergency_contact_dialog.dart';

class EmergencyContactsWidget extends StatefulWidget {
  const EmergencyContactsWidget({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsWidget> createState() =>
      _EmergencyContactsWidgetState();
}

class _EmergencyContactsWidgetState extends State<EmergencyContactsWidget> {
  List<Widget> list1 = [];
  List<Widget> list2 = [];
  List<Contact> contacts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _distributeContacts(List<Contact> contacts) {
    // Clear lists before repopulating
    list1.clear();
    list2.clear();

    // Iterate through the contacts and distribute them
    for (int i = 0; i < contacts.length; i++) {
      if (i % 2 == 0) {
        list1.add(EmergencyContactWidget(
          name: contacts[i].name,
          phone: contacts[i].phone, contactIndex: i,
        ));
        list1.add(const SizedBox(
          height: 24,
        ));
      } else {
        list2.add(EmergencyContactWidget(
          contactIndex: i,
          name: contacts[i].name,
          phone: contacts[i].phone,
        ));
        list2.add(const SizedBox(
          height: 24,
        ));
      }
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyContactDialog(
          title: 'Add Emergency Contact',
          submit: 'Add contact',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsContainerWidget(
        title: "Emergency contacts",
        child: BlocBuilder<EmergencyContactsBloc, EmergencyContactsState>(
            builder: (context, state) {
              if (state is EmergencyContactsLoaded) {
                contacts = state.contacts;
                _distributeContacts(contacts);

                return Column(
                  children: [
                    list1.isNotEmpty || list2.isNotEmpty
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: list1,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: list2,
                          ),
                        )
                      ],
                    )
                        : Column(
                      children: [
                        Text(
                          "Your list of contacts is empty",
                          style: TextStylesConstants.bodyLarge
                              .copyWith(color: const Color(0xff878C99)),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                          onTap: () => _showDialog(context),
                          text: "Add contact",
                          icon: SvgPicture.asset(
                            'assets/icons/add.svg',
                            width: 24,
                            height: 24,
                          ),
                          padding: const EdgeInsets.all(24),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    if (list1.isNotEmpty || list2.isNotEmpty)
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            padding: const EdgeInsets.all(2),
                            constraints: const BoxConstraints(),
                            onPressed: () => _showDialog(context),
                            icon: SvgPicture.asset(
                                'assets/icons/add-circle.svg'),
                            iconSize: 70,
                          ))
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            })
    );
  }

}
