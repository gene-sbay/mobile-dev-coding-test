import 'package:flutter/material.dart';
import 'package:qr_code_demo/app/appRoutes.dart';

void main() => runApp(AppStart());

class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Client/Server Demo',
      theme: ThemeData.light(),
      initialRoute: AppRoutes.initialRoute(),
      routes: AppRoutes.getRouteMap()
    );
  }
}

