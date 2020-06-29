import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_demo/app/logger.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

void main() => runApp(QrScannerScreen());

class QrScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new QrScannerStatefulWidget();
  }
}

class QrScannerStatefulWidget extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScannerStatefulWidget> {
  static const DEFAULT_SCAN_VALUE = 'Scan a QR Code';

  String _qrCodeData;
  bool _isCameraOn = false;

  List<Widget> _mainColumnWidgets;

  Logger log = getLogger("QrScannerScreen");

  _qrCallback(String code) {
    setState(() {
      _isCameraOn = false;
      _qrCodeData = code;

      log.i('_qrCodeData: $_qrCodeData');
    });
  }

  _scanCode() {
    setState(() {
      _isCameraOn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    _mainColumnWidgets = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      // body: Text(_qrCodeData),
      body: Container(
          // color: Colors.amber,
          child: Center(
        child: _getMainLayout(),
      )),
      floatingActionButton: Visibility(
        visible: !_isCameraOn,
        child: FloatingActionButton(
          onPressed: _scanCode,
          tooltip: 'Scan',
          child: Icon(Icons.scanner),
        ),
      ),
    );
  }

  _clearScannedData() {
    _qrCodeData = null;
  }

  Widget _getMainLayout() {
    if (_isCameraOn) {
      _setActiveCameraView();
    } else {
      _setCameraOffView();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _mainColumnWidgets,
    );
  }

  _setCameraOffView() {
    if (_qrCodeData != null) {
      _mainColumnWidgets.add(
        Text(
          'QR Code Value:',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      _qrCodeData = DEFAULT_SCAN_VALUE;
    }

    _mainColumnWidgets.add(
      Center(
          child: Text(
        _qrCodeData,
        style: TextStyle(fontSize: 25),
      )),
    );
  }

  _setActiveCameraView() {
    Widget closeCameraWidget = RaisedButton(
      color: Colors.white,
      child: Text(
        'Close Scanner',
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
      onPressed: () {
        log.i('pressed Close Scanner');
        setState(() {
          _clearScannedData();
          _isCameraOn = false;
        });
      },
    );

    Widget cameraWidget = Center(
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
    );

    _mainColumnWidgets.add(closeCameraWidget);
    _mainColumnWidgets.add(cameraWidget);
  }
}

/*

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
 */
