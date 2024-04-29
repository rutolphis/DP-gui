import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/models/adress.dart';
import 'package:gui_flutter/models/personal_info.dart';
import 'package:gui_flutter/widgets/button.dart';
import 'package:gui_flutter/widgets/progress_indicator.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class PersonalInformationDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;
  final TextEditingController _addressController;
  final TextEditingController _bloodGroupController;
  final TextEditingController _insuranceCompanyController;
  final PersonalInfo? personalInfo;
  final String title; // Parameter for dynamic name content
  final String submit;

  PersonalInformationDialog({
    Key? key,
    required this.title,
    required this.submit,
    this.personalInfo,
  })
      : _nameController = TextEditingController(text: personalInfo?.name ?? ''),
        _addressController =
        TextEditingController(text: personalInfo?.address.toString() ?? ''),
  // Initialize with provided data or empty string
        _bloodGroupController =
        TextEditingController(text: personalInfo?.bloodGroup ?? ''),
        _insuranceCompanyController =
        TextEditingController(text: personalInfo?.insuranceCompany ?? ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      // Assuming ColorConstants.white exists
      contentPadding: const EdgeInsets.all(24),
      content: SingleChildScrollView(
        // Use SingleChildScrollView to avoid overflow
        child: MultiBlocListener(
          listeners: [
            BlocListener<PersonalInfoBloc, PersonalInfoState>(
              listenWhen: (previousState, state) =>
              previousState is PersonalInfoLoading &&
                  state is PersonalInfoLoaded,
              listener: (context, state) => Navigator.of(context).pop(),
            ),
            BlocListener<PersonalInfoBloc, PersonalInfoState>(
              listenWhen: (previousState, state) =>
              state is PersonalInfoError,
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        'Error while updating personal informations.'))
                );
                Navigator.of(context).pop();
              },
            )
          ],
          child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
              builder: (context, state) {
                if (state is PersonalInfoLoaded) {
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
                          // Assuming TextStylesConstants.h2 exists
                          const SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.of(context).pop(); // Closes the dialog
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.black,
                              // Assuming ColorConstants.black exists
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
                            // Repeated CustomTextFieldWidget for each field
                            // Name
                            CustomTextFieldWidget(
                              controller: _nameController,
                              hintText: 'Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                            const SizedBox(height: 16),
                            // Address
                            CustomTextFieldWidget(
                              controller: _addressController,
                              hintText: 'Address',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Blood Group
                            CustomTextFieldWidget(
                              controller: _bloodGroupController,
                              hintText: 'Blood Group',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your blood group';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Insurance Company
                            CustomTextFieldWidget(
                              controller: _insuranceCompanyController,
                              hintText: 'Insurance Company',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the name of your insurance company';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(
                                      ColorConstants.primary),
                                  padding: MaterialStateProperty.resolveWith<
                                      EdgeInsetsGeometry>(
                                        (Set<MaterialState> states) {
                                      return const EdgeInsets.all(20);
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ))),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  PersonalInfo updatedPersonalInfo = PersonalInfo(
                                      name: _nameController.text,
                                      address: _addressController.text,
                                      bloodGroup: _bloodGroupController.text,
                                      insuranceCompany:
                                      _insuranceCompanyController.text);
                                  context
                                      .read<PersonalInfoBloc>()
                                      .add(
                                      UpdatePersonalInfo(updatedPersonalInfo));
                                }
                              },
                              child: Text(
                                submit,
                                style: TextStylesConstants.bodyBase
                                    .copyWith(color: ColorConstants.white),
                              ), // Assuming TextStylesConstants.bodyBase exists
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
      ),
    );
  }
}
