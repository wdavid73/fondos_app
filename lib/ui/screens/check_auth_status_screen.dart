import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';

class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                "Checking auth status...",
                style: context.textTheme.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
