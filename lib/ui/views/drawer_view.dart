import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer"),
      ),
      drawer: _Drawer(),
      body: Center(
        child: FilledButton(
          onPressed: () => context.pop(),
          child: Text("Back"),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Text("Drawer Title"),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Disable"),
              subtitle: Text("SubTitle"),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Enable"),
              subtitle: Text("SubTitle"),
              trailing: Icon(Icons.adaptive.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              title: Text("Selected"),
              selected: true,
            ),
            ListTile(
              title: Text("Selected with icons"),
              leading: Icon(Icons.add),
              trailing: Icon(Icons.adaptive.arrow_forward),
              selected: true,
            ),
            ListTile(title: Text("Item 5")),
            ListTile(title: Text("Item 6")),
          ],
        ),
      ),
    );
  }
}