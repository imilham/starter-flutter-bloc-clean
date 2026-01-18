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
        title: context.l10n.profile,
        icon: Icons.person_outline,
        onTap: () {
          Pages.profile.go(context);
        },
      ),
      MenuItem( 
        title: context.l10n.settings,
        icon: Icons.settings_outlined,
        onTap: () {
          Pages.settings.go(context);
        },
      ),
      MenuItem(
        title: context.l10n.helpSupport,
        icon: Icons.help_outline,
        onTap: () {
          // TODO(ilham): Navigate to help page
        },
      ),
      MenuItem(
        title: context.l10n.designSystem,
        icon: Icons.palette_outlined,
        onTap: () {
          Pages.designSystem.push(context);
        },
      ),
      MenuItem(
        title: context.l10n.about,
        icon: Icons.info_outline,
        onTap: () {
          // TODO(ilham): Navigate to about page
        },
      ),
      MenuItem(
        title: context.l10n.logout,
        icon: Icons.logout,
        onTap: () async {
          await controller.logout(context);
        },
      ),
    ];

    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.more,
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(
              item.title,
              style: bodyRegular16(),
            ),
            subtitle: item.subtitle != null
                ? Text(
                    item.subtitle!,
                    style: tab10(),
                  )
                : null,
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}
