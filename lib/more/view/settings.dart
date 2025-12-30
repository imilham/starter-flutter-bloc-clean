import 'package:flutter/material.dart';
import 'package:starter/app/controller/controller.dart';
import 'package:starter/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            Gap.medium16,
            const Text('Settings Page'),
            Gap.medium16,
            // theme toggle switch
            Consumer<ThemeServiceProvider>(
              builder: (context, themeProvider, child) => Switch(
                value: themeProvider.isDark,
                onChanged: (value) => themeProvider.toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
