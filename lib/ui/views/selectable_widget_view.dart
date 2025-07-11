import 'package:flutter/material.dart';

class SelectableWidgetView extends StatelessWidget {
  const SelectableWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selectable Widget View"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Radio Widget"),
              RadioWidget(),
              const Divider(),
              Text("Checkbox Widget"),
              CheckboxWidget(),
              const Divider(),
              Text("Switch Widget"),
              SwitchWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
  });

  final bool groupValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: false,
          groupValue: groupValue,
          onChanged: (val) {},
        ),
        Radio(
          value: true,
          groupValue: groupValue,
          onChanged: (val) {},
        ),
      ],
    );
  }
}

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (val) {}),
        Checkbox(value: true, onChanged: (val) {}),
      ],
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(value: false, onChanged: (val) {}),
        Switch(value: true, onChanged: (val) {}),
      ],
    );
  }
}