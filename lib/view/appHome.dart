import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_demo/app/appRoutes.dart';
import 'package:qr_code_demo/app/logger.dart';

class AppHomeScreen extends StatelessWidget {
  static String route = 'AppHome';

  @override
  Widget build(BuildContext ctxt) {
    return new AppHomeStatefulWidget();
  }
}

class AppHomeStatefulWidget extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHomeStatefulWidget> {

  Logger log = getLogger("AppHomeScreen");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Demo Start Screen'),
      ),
      body: _getMainLayout(),
    );
  }

  Widget _getMainLayout() {
    return Center(
      child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                log.i('pressed Scan');
                Navigator.pushNamed(context, AppRoutes.QrScanner);
              },
              tooltip: 'Scan',
              child: Icon(Icons.scanner),
            ),
            SizedBox(
              width: 30,
            ),
            RaisedButton(
              color: Colors.white,
              child: Text(
                'Expiring Qr Code',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              onPressed: () {
                log.i('pressed Expiring Qr Code');
                Navigator.pushNamed(context, AppRoutes.ExpiringQrCode);
              },
            ),
          ]),
    );
  }
}
