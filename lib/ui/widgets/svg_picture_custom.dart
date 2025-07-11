import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPictureCustom extends StatelessWidget {
  final String iconPath;
  final double iconSize;
  final Alignment alignment;
  final BoxFit fit;

  const SvgPictureCustom({
    super.key,
    required this.iconPath,
    this.iconSize = 30,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: iconSize,
      height: iconSize,
      alignment: alignment,
      fit: fit,
    );
  }
}