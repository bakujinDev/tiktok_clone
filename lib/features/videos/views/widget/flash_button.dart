import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final Function onTap;
  final FlashMode flashMode;
  final FlashMode currentFlashMode;
  final IconData iconData;

  const FlashButton({
    super.key,
    required this.onTap,
    required this.flashMode,
    required this.currentFlashMode,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap(flashMode),
      icon: Icon(iconData),
      color: currentFlashMode == flashMode ? Colors.amber.shade200 : Colors.white,
    );
  }
}
