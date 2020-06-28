import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Reader',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _qrInfo = 'Scan a Code';
  bool _camState = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;

      print('_qrInfo: $_qrInfo');
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter QR Reader Tutorial'),
      ),
      // body: Text(_qrInfo),
      body: _camState
          ? Center(
        child: SizedBox(
          width: 256,
          height: 512,
          child: QrCamera(
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              _qrCallback(code);
            },
          ),
        ),
      )
          : Center(
        child: Text(_qrInfo),
      ),
      floatingActionButton: Visibility(
        visible: !_camState,
        child: FloatingActionButton(
          onPressed: _scanCode,
          tooltip: 'Scan',
          child: Icon(Icons.scanner),
        ),
      ),
    );
  }
}
