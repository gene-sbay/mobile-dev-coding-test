import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_demo/app/logger.dart';
import 'package:qr_code_demo/bloc/qrSeedBloc.dart';
import 'package:qr_code_demo/model/qrSeed.dart';
import 'package:qr_code_demo/network/apiResponse.dart';

class ExpiringQrCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new ExpiringQrCodeStatefulWidget();
  }
}

class ExpiringQrCodeStatefulWidget extends StatefulWidget {
  @override
  _ExpiringQrCodeState createState() => _ExpiringQrCodeState();
}

class _ExpiringQrCodeState extends State<ExpiringQrCodeStatefulWidget> {
  Logger log = getLogger("ExpiringQrCodeScreen");

  QrSeedBloc _qrSeedBloc;

  @override
  void initState() {
    super.initState();
    _qrSeedBloc = QrSeedBloc();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Expiring QR Code'),
      ),
      body: _getScreenStreamBuilder(),
    );
  }

  Widget _getScreenStreamBuilder() {
    StreamBuilder<ApiResponse<QrSeed>> streamBuilder =
        StreamBuilder<ApiResponse<QrSeed>>(
      stream: _qrSeedBloc.qrSeedDataStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Loading(loadingMessage: snapshot.data.message);
              break;
            case Status.COMPLETED:
              return QrSeedDisplay(qrSeed: snapshot.data.data);
              break;
            case Status.ERROR:
              return Error(
                errorMessage: snapshot.data.message,
                onRetryPressed: () => _qrSeedBloc.fetchNextSeed(),
              );
              break;
          }
        }
        return Container(
            child: Center(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Text('Standing by for data', style: TextStyle(fontSize: 25))
            ])));
      },
    );

    return streamBuilder;
  }
  
  @override
  void dispose() {
    _qrSeedBloc.dispose();
    super.dispose();
  }
}

class QrSeedDisplay extends StatelessWidget {
  final QrSeed qrSeed;

  const QrSeedDisplay({Key key, this.qrSeed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: new Stack(
          children: <Widget>[
            // _getBackground(),
            _getGradient(context),
            _getContent(),
          ],
        ),
      ),
    );
  }

  Container _getGradient(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: 90.0),
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), new Color(0xFF333333)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    String qrSeedValue = '${qrSeed.seed}';

    return new ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 280, 0.0, 32.0),
      children: <Widget>[
        new Container(
          margin: EdgeInsets.all(70.0),
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          padding: new EdgeInsets.symmetric(horizontal: 32.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  qrSeedValue,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
