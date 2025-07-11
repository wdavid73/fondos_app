import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FlutterLogo(
        size: context.dp(7),
      ),
    );
  }
}
