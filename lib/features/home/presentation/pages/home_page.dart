import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.home,
      ),
      body: Center(
        child: Text(
          context.l10n.homeContent,
          style: context.bodyRegular16(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
