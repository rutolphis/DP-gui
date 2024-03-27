import 'package:flutter/material.dart';

class ImageContainerWidget extends StatelessWidget {
  final String backgroundImage; // Make backgroundImage required and non-nullable
  final double height;

  const ImageContainerWidget({
    Key? key,
    required this.backgroundImage, required this.height // backgroundImage is now required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent, // Color is transparent to show the backgroundImage
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 15, offset: const Offset(0, 38)),
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 13, offset: const Offset(0, 22)),
          BoxShadow(color: Colors.black.withOpacity(0.09), blurRadius: 10, offset: const Offset(0, 10)),
          BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover, // Ensures the image covers the whole container
              ),
            ),
          ],
        ),
      ),
    );
  }
}
