import 'package:flutter/material.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Sheet View"),
      ),
      body: Center(
        child: const _BottomSheet(),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              width: 450,
              height: 250,
              child: Center(
                child: Text(
                  "Bottom Sheet",
                ),
              ),
            );
          },
        );
      },
      child: Text("Show BottomSheet"),
    );
  }
}