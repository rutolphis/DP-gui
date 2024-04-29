import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_bloc.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_event.dart';
import 'package:gui_flutter/bloc/emergency_contacts/emergency_contacts_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/contact.dart';
import 'package:gui_flutter/widgets/progress_indicator.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class EmergencyContactDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final String? name;
  final String? phone;
  final String title; // Parameter for dynamic name content
  final String submit;
  final int? contactIndex;

  EmergencyContactDialog(
      {Key? key,
      required this.title,
      required this.submit,
      this.name,
      this.phone,
      this.contactIndex})
      : super(key: key) {
    // Assign the initial values to the text controllers
    _nameController.text =
        name ?? ''; // If name is null, default to an empty string
    _phoneController.text =
        phone ?? ''; // If phone is null, default to an empty string
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstants.white,
      contentPadding: const EdgeInsets.all(24),
      content: MultiBlocListener(
        listeners: [
          BlocListener<EmergencyContactsBloc, EmergencyContactsState>(
            listenWhen: (previousState, state) =>
                previousState is EmergencyContactsLoading &&
                state is EmergencyContactsLoaded,
            listener: (context, state) => Navigator.of(context).pop(),
          ),
          BlocListener<EmergencyContactsBloc, EmergencyContactsState>(
            listenWhen: (previousState, state) =>
                state is EmergencyContactsError,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Error while updating emergency contact.')));
              Navigator.of(context).pop();
            },
          )
        ],
        child: BlocBuilder<EmergencyContactsBloc, EmergencyContactsState>(
            builder: (context, state) {
            if(state is EmergencyContactsLoaded)  {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStylesConstants.h2,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.of(context).pop(); // Closes the dialog
                      },
                      child: const CircleAvatar(
                        backgroundColor: ColorConstants.black,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextFieldWidget(
                        controller: _nameController,
                        hintText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      CustomTextFieldWidget(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorConstants.primary),
                            padding: MaterialStateProperty.resolveWith<
                                EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                                return const EdgeInsets.all(20);
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ))),
                        onPressed: () {
                          var state =
                              context.read<EmergencyContactsBloc>().state;
                          if (_formKey.currentState!.validate() &&
                              state is EmergencyContactsLoaded) {
                            if (name == '' || name == null) {
                              context.read<EmergencyContactsBloc>().add(
                                    AddEmergencyContact(
                                        Contact(
                                            name: _nameController.text,
                                            phone: _phoneController.text),
                                        state.vin),
                                  );
                            } else {
                              final updatedContact = Contact(
                                  name: _nameController.text,
                                  phone: _phoneController.text);
                              context.read<EmergencyContactsBloc>().add(
                                    UpdateEmergencyContact(contactIndex!,
                                        updatedContact, state.vin),
                                  );
                            }
                          }
                        },
                        child: Text(
                          submit,
                          style: TextStylesConstants.bodyBase
                              .copyWith(color: ColorConstants.white),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (name != null && name != '')
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              padding: MaterialStateProperty.resolveWith<
                                  EdgeInsetsGeometry>(
                                (Set<MaterialState> states) {
                                  return const EdgeInsets.all(20);
                                },
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                          onPressed: () {
                            var state =
                                context.read<EmergencyContactsBloc>().state;
                            if (state is EmergencyContactsLoaded) {
                              context.read<EmergencyContactsBloc>().add(
                                  DeleteEmergencyContact(
                                      contactIndex!, state.vin));
                            }
                          },
                          child: Text(
                            "Delete contact",
                            style: TextStylesConstants.bodyBase
                                .copyWith(color: ColorConstants.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
              return const SizedCircularProgressIndicator();
            }
        }),
      ),
    );
  }
}
