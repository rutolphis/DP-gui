import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class PersonalInformationDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _addressController;
  final TextEditingController _bloodGroupController;
  final TextEditingController _insuranceCompanyController;

  final String title; // Parameter for dynamic name content
  final String submit;
  final Function(String name, String phone, String address, String bloodGroup, String insuranceCompany) onSubmit; // Updated callback function for form submission

  PersonalInformationDialog({
    Key? key,
    required this.title,
    required this.onSubmit,
    required this.submit,
    String? name, // Optional parameters for initial data
    String? phone,
    String? address,
    String? bloodGroup,
    String? insuranceCompany,
  })
      : _nameController = TextEditingController(text: name),
        _phoneController = TextEditingController(text: phone),
        _addressController = TextEditingController(text: address ?? ''),
  // Initialize with provided data or empty string
        _bloodGroupController = TextEditingController(text: bloodGroup ?? ''),
        _insuranceCompanyController = TextEditingController(
            text: insuranceCompany ?? ''),
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
      content: SingleChildScrollView( // Use SingleChildScrollView to avoid overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStylesConstants.h2,),
                // Assuming TextStylesConstants.h2 exists
                const SizedBox(width: 40,),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Navigator.of(context).pop(); // Closes the dialog
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    // Assuming ColorConstants.black exists
                    child: Icon(Icons.close, color: Colors.white, size: 30,),
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
                      controller: _nameController, hintText: 'Name'),
                  const SizedBox(height: 16),
                  // Phone
                  CustomTextFieldWidget(controller: _phoneController,
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                  // Address
                  CustomTextFieldWidget(
                      controller: _addressController, hintText: 'Address'),
                  const SizedBox(height: 16),
                  // Blood Group
                  CustomTextFieldWidget(controller: _bloodGroupController,
                      hintText: 'Blood Group'),
                  const SizedBox(height: 16),
                  // Insurance Company
                  CustomTextFieldWidget(controller: _insuranceCompanyController,
                      hintText: 'Insurance Company'),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.primary),
                        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                            return const EdgeInsets.all(20);
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        )
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onSubmit(
                            _nameController.text,
                            _phoneController.text,
                            _addressController.text,
                            _bloodGroupController.text,
                            _insuranceCompanyController.text
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(submit, style: TextStylesConstants.bodyBase.copyWith(color: ColorConstants.white),), // Assuming TextStylesConstants.bodyBase exists
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}