import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
import 'package:gui_flutter/constants/fonts.dart';

import '../pages/home/widgets/connect_button.dart';
class PageWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? button;

  const PageWidget({Key? key, required this.title, required this.body, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(title, style: TextStylesConstants.h1,),
              button != null ? button! : Container()
            ],),
            const SizedBox(height: 40,),
            body
          ],
        ),
      ),
    );
  }
}
