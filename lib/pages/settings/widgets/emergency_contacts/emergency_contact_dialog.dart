import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';
import 'package:gui_flutter/widgets/text_field.dart';

class EmergencyContactDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final String title; // Parameter for dynamic name content
  final String submit;
  final Function(String name, String phone) onSubmit; // Callback function for form submission

  EmergencyContactDialog({Key? key, required this.title, required this.onSubmit, required this.submit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstants.white,
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStylesConstants.h2,),
              const SizedBox(width: 40,),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  Navigator.of(context).pop(); // Closes the dialog
                },
                child: const CircleAvatar(
                  backgroundColor: ColorConstants.black,
                  child: Icon(Icons.close, color: Colors.white,size: 30,),
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
                    if (value == null || value.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
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
                      onSubmit(_nameController.text, _phoneController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(submit, style: TextStylesConstants.bodyBase.copyWith(color: ColorConstants.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
