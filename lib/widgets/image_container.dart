import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_data/vehicle_data_state.dart';
import 'package:gui_flutter/bloc/vehicle_frame/vehicle_frame_bloc.dart';
import 'package:gui_flutter/bloc/vehicle_frame/vehicle_frame_state.dart';
import 'package:gui_flutter/widgets/progress_indicator.dart';

class ImageContainerWidget extends StatelessWidget {
  final String
      backgroundImage; // Make backgroundImage required and non-nullable
  final double height;

  const ImageContainerWidget(
      {Key? key,
      required this.backgroundImage,
      required this.height // backgroundImage is now required
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleFrameBloc, VehicleFrameState>(
        builder: (context, state) {
      if (state is VehicleFrameUpdate) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            // Color is transparent to show the backgroundImage
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 15,
                  offset: const Offset(0, 38)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 13,
                  offset: const Offset(0, 22)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 10,
                  offset: const Offset(0, 10)),
              BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 5,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Positioned.fill(
                  child:
                      state.frame != null && state.frame!.isNotEmpty
                          ? Image.memory(base64Decode(
                              state.frame!
                            ),fit: BoxFit.cover, gaplessPlayback: true,)
                          : Image.asset(
                              "assets/images/test_photo.jpg",
                              fit: BoxFit
                                  .cover, // Ensures the image covers the whole container
                            ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const SizedCircularProgressIndicator();
      }
    });
  }
}
