import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';
import 'package:fondos_app/ui/views/views.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => context.unfocus(),
        child: LoginView(),
      ),
    );
  }
}
