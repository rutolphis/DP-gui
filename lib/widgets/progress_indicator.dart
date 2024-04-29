import 'package:flutter/material.dart';
import 'package:gui_flutter/constants/colors.dart';
class SizedCircularProgressIndicator extends StatelessWidget {
  final double size;
  const SizedCircularProgressIndicator({Key? key, this.size = 40}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width:size, child: const Center(child: CircularProgressIndicator(color: ColorConstants.primary,),));
  }
}
