import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                "Joe Doe",
                style: context.textTheme.bodyLarge,
              ),
              subtitle: Text(
                "joe@doe.com",
                style: context.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
