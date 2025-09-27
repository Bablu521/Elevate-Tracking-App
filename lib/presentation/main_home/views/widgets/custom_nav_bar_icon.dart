import 'package:elevate_tracking_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomNavBarIcon extends StatelessWidget {
  final String imagePath;
  final bool isSelected;
  const CustomNavBarIcon({
    super.key,
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(AssetImage(imagePath), color: isSelected 
          ? AppColors.mainColor 
          : AppColors.white[80],);
  }
}
