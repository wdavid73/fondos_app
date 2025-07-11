import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';

class TextStylesView extends StatelessWidget {
  const TextStylesView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Text Styles View"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('displayLarge', style: textTheme.displayLarge),
              Text('displayMedium', style: textTheme.displayMedium),
              Text('displaySmall', style: textTheme.displaySmall),
              Text('headlineLarge', style: textTheme.headlineLarge),
              Text('headlineMedium', style: textTheme.headlineMedium),
              Text('headlineSmall', style: textTheme.headlineSmall),
              Text('titleLarge', style: textTheme.titleLarge),
              Text('titleMedium', style: textTheme.titleMedium),
              Text('titleSmall', style: textTheme.titleSmall),
              Text('bodyLarge', style: textTheme.bodyLarge),
              Text('bodyMedium', style: textTheme.bodyMedium),
              Text('bodySmall', style: textTheme.bodySmall),
              Text('labelLarge', style: textTheme.labelLarge),
              Text('labelMedium', style: textTheme.labelMedium),
              Text('labelSmall', style: textTheme.labelSmall),
            ]
                .map(
                  (widget) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: widget,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
