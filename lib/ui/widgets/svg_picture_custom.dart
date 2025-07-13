import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable widget for displaying SVG images from assets.
///
/// This widget wraps [SvgPicture.asset] and allows customization of size, alignment, and fit.
class SvgPictureCustom extends StatelessWidget {
  /// The path to the SVG asset.
  final String iconPath;

  /// The size (width and height) of the icon. Defaults to 30.
  final double iconSize;

  /// The alignment of the SVG within its container. Defaults to [Alignment.center].
  final Alignment alignment;

  /// How the SVG should be inscribed into the space allocated. Defaults to [BoxFit.contain].
  final BoxFit fit;

  /// Creates a [SvgPictureCustom] widget.
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
