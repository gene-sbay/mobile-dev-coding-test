import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:http/http.dart' as http;


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

  Future<String> callServer1() async {

    // String localhost = "69.181.92.143";
    String localhost = "10.0.2.2";

    final response = await http.get('http://$localhost:8000/ping');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('response.body: ${response.body}');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load end point');
    }
  }

  @override
  Widget build(BuildContext context) {

    callServer1();

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter QR Reader'),
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
