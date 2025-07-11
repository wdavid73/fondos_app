import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widgets"),
        actions: [
          Icon(Icons.favorite),
          Icon(Icons.settings),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 32),
        /*child: Text("Add"),*/
        /*label: Row(
          children: [
            Icon(Icons.add),
            Text("FAB"),
          ],
        ),*/
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.text_fields),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to TextStyles View"),
                  onTap: () => context.push('/widgets/text_styles_view'),
                ),
                ListTile(
                  leading: Icon(Icons.input),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to Inputs View"),
                  onTap: () => context.push('/widgets/inputs_view'),
                ),
                ListTile(
                  leading: Icon(Icons.select_all),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to Selectable Widget View"),
                  onTap: () => context.push('/widgets/selectable_widget_view'),
                ),
                ListTile(
                  leading: Icon(Icons.draw),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to Drawer View"),
                  onTap: () => context.push('/widgets/drawer_view'),
                ),
                ListTile(
                  leading: Icon(Icons.smart_button),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to Buttons View"),
                  onTap: () => context.push('/widgets/buttons_view'),
                ),
                ListTile(
                  leading: Icon(Icons.ad_units),
                  trailing: Icon(Icons.adaptive.arrow_forward),
                  title: Text("Go to Bottom Sheet View"),
                  onTap: () => context.push('/widgets/bottom_sheet_view'),
                ),
                const Divider(),
                _IconsWidget(),
                const Divider(),
                _ChipWidget(),
                const Divider(),
                Text(
                  "SnackBar",
                  style: context.textTheme.titleMedium,
                ),
                FilledButton(
                  onPressed: () {
                    CustomSnackBar.showSnackBar(
                      context,
                      message: "Hello World!",
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {},
                      ),
                    );
                  },
                  child: Text("Show SnackBar"),
                ),
                const Divider(),
                Text(
                  "Progress Indicators",
                  style: context.textTheme.titleMedium,
                ),
                CircularProgressIndicator(),
                const SizedBox(height: 10),
                LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconsWidget extends StatelessWidget {
  const _IconsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Icons",
          style: context.textTheme.titleMedium,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            Icon(Icons.favorite),
            Icon(Icons.linked_camera),
            Icon(Icons.add),
          ],
        ),
      ],
    );
  }
}

class _ChipWidget extends StatelessWidget {
  const _ChipWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Chip Widget",
          style: context.textTheme.titleMedium,
        ),
        Row(
          spacing: 10,
          children: [
            Chip(
              label: Text(
                "Chip #1",
                style: context.textTheme.bodyMedium,
              ),
            ),
            Chip(
                label: Text(
              "Chip #2",
              style: context.textTheme.bodyMedium,
            )),
            Chip(
                label: Text(
              "Chip #3",
              style: context.textTheme.bodyMedium,
            )),
          ],
        ),
      ],
    );
  }
}
