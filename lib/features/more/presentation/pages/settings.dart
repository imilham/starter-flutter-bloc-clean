import 'package:flutter/material.dart';
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
      appBar: CommonAppBar(
        title: context.l10n.settings,
      ),
      body: const Center(
        child: Column(),
      ),
    );
  }
}
