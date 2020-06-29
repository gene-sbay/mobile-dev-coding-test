import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_demo/app/logger.dart';

void main() => runApp(QrScannerScreen());

class QrScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: QrScannerStatefulWidget(),
    );
  }
}

class QrScannerStatefulWidget extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScannerStatefulWidget> {
  String _qrInfo = 'Scan a Code';
  bool _camState = false;

  Logger log = getLogger("QrScannerScreen");

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;

      log.i('_qrInfo: $_qrInfo');
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  Future<String> callServer1() async {
    // String localhost = "69.181.92.143";
    String localhost = "10.0.2.2";

    final response = await http.get('http://$localhost:8000/ping');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log.i('response.body: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load end point');
    }
  }

  @override
  Widget build(BuildContext context) {
    // callServer1();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter QR Reader'),
      ),
      // body: Text(_qrInfo),
      body: _getMainLayout(),
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

  Widget _getMainLayout() {
    Widget cameraWidget = _camState
        ? Center(
            child: SizedBox(
              width: 512,
              height: 256,
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
        : Center(child: Text(_qrInfo));

    return Column(
      children: [
        cameraWidget
      ]
    );
  }
}

