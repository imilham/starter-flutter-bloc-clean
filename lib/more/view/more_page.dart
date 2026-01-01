import 'package:flutter/material.dart';
import 'package:starter/more/controller/controller.dart';
import 'package:starter/more/model/model.dart';
import 'package:starter/utils/utils.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GetIt.instance<MoreController>();

    final menuItems = [
      MenuItem(
        title: 'Profile',
        icon: Icons.person_outline,
        onTap: () {
          Pages.profile.go(context);
        },
      ),
      MenuItem(
        title: 'Settings',
        icon: Icons.settings_outlined,
        onTap: () {
          Pages.settings.go(context);
        },
      ),
      MenuItem(
        title: 'Help & Support',
        icon: Icons.help_outline,
        onTap: () {
          // TODO(ilham): Navigate to help page
        },
      ),
      MenuItem(
        title: 'Component Examples',
        icon: Icons.design_services_outlined,
        onTap: () {
          Pages.example.push(context);
        },
      ),
      MenuItem(
        title: 'About',
        icon: Icons.info_outline,
        onTap: () {
          // TODO(ilham): Navigate to about page
        },
      ),
      MenuItem(
        title: 'Logout',
        icon: Icons.logout,
        onTap: () async {
          await controller.logout(context);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}
