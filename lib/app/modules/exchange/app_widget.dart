import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Exchange App',
      theme: ThemeData.dark(),
      routerConfig: Modular.routerConfig,
    );
  }
}