import 'package:flutter/material.dart';
import 'package:fondos_app/config/config.dart';

/// A custom header widget for navigation drawers.
///
/// Displays a user avatar, name, and email in a horizontal layout.
class CustomDrawerHeader extends StatelessWidget {
  /// Creates a [CustomDrawerHeader] widget.
  const CustomDrawerHeader({super.key});

  @override

  /// Builds the widget tree for the custom drawer header.
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
