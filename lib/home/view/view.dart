import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Home',
      ),
      body: Center(
        child: Text(
          'Home Content',
          style: bodyRegular(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
