import 'package:flutter/material.dart';

class ButtonsView extends StatelessWidget {
  const ButtonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buttons Widget"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: const _ButtonsWidgets(),
          ),
        ),
      ),
    );
  }
}

class _ButtonsWidgets extends StatelessWidget {
  const _ButtonsWidgets();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("ElevatedButton:"),
            const SizedBox(width: 50),
            ElevatedButton(
              onPressed: () {},
              child: Text("Press me!"),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("TextButton:"),
            const SizedBox(width: 50),
            TextButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("OutlinedButton:"),
            const SizedBox(width: 50),
            OutlinedButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("FilledButton:"),
            const SizedBox(width: 50),
            FilledButton(onPressed: () {}, child: Text("Press me!")),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Icon Button:"),
            const SizedBox(width: 50),
            IconButton(onPressed: () {}, icon: Icon(Icons.adb)),
          ],
        ),
      ],
    );
  }
}