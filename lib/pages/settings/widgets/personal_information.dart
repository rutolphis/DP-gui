import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_bloc.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_event.dart';
import 'package:gui_flutter/bloc/personal_info/personal_info_state.dart';
import 'package:gui_flutter/bloc/socket/socket_bloc.dart';
import 'package:gui_flutter/bloc/socket/socket_state.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/models/personal_info.dart';
import 'package:gui_flutter/pages/settings/widgets/personal_information_dialog.dart';
import 'package:gui_flutter/pages/settings/widgets/personal_information_item.dart';
import 'package:gui_flutter/pages/settings/widgets/settings_container.dart';
import 'package:gui_flutter/widgets/button.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  late PersonalInfo _personalInfo;

  Widget _Divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        height: 2,
        color: ColorConstants.secondary,
      ),
    );
  }

  void _showDialog(PersonalInfo personalInfo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PersonalInformationDialog(
            personalInfo: personalInfo,
            title: 'Edit personal information',
            submit: 'Save changes',
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsContainerWidget(
        title: "Personal information",
        onIconTap: () => _showDialog(_personalInfo),
        child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        builder: (context, state) {
          if (state is PersonalInfoLoaded) {
            _personalInfo = state.personalInfo;
          return Column(
            children: [
              PersonalInfromationItemWidget(
                itemName: "Name",
                itemValue: _personalInfo.name,
              ),
              _Divider(),
              PersonalInfromationItemWidget(
                itemName: "Address",
                itemValue: _personalInfo.address.toString(),
              ),
              _Divider(),
              PersonalInfromationItemWidget(
                itemName: "Blood group",
                itemValue: _personalInfo.bloodGroup,
              ),
              _Divider(),
              PersonalInfromationItemWidget(
                itemName: "Insurance company",
                itemValue: _personalInfo.insuranceCompany,
              )
            ],
          ); }
          else if (state is PersonalInfoLoading) {
          return const Center (child: CircularProgressIndicator ()
          );
        } else {
            return CustomButton(onTap: () {
              var loadedState =
                  BlocProvider.of<SocketBloc>(context, listen: false)
                      .state;
              if (loadedState is SocketInitialized) {
                BlocProvider.of<PersonalInfoBloc>(context, listen: false)
                    .add(LoadPersonalInfo(loadedState.vin));
              }
            }, text: "Try again");
          }
        })
        );
  }
}
