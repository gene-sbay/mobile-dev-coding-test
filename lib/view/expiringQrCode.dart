import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_demo/app/appConfig.dart';
import 'package:qr_code_demo/app/appUi.dart';
import 'package:qr_code_demo/app/logger.dart';
import 'package:qr_code_demo/bloc/qrSeedBloc.dart';
import 'package:qr_code_demo/model/qrSeed.dart';
import 'package:qr_code_demo/network/apiResponse.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

class _ExpiringQrCodeState extends State<ExpiringQrCodeStatefulWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  Logger log = getLogger("ExpiringQrCodeScreen");

  QrSeed _qrSeed;
  QrSeedBloc _qrSeedBloc;

  static const int kStartValue = AppConfig.QrTimeoutSeconds;

  @override
  void initState() {
    super.initState();
    _qrSeedBloc = QrSeedBloc();

    _animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: kStartValue),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fetchNextSeed();
      }
    });
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
              _qrSeed = snapshot.data.data;

              return getSeedDisplayContainer();
              break;
            case Status.ERROR:
              return Error(
                errorMessage: snapshot.data.message,
                onRetryPressed: () => _fetchNextSeed(),
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

  _fetchNextSeed() {
    _qrSeedBloc.fetchNextSeed();
    _animationController.forward(from: 0.0);
  }

  Container getSeedDisplayContainer() {
    return Container(
      constraints: new BoxConstraints.expand(),
      // color: new Color(0xFF736AB7),
      child: new Stack(
        children: <Widget>[
          // _getBackground(),
          // _getGradient(context),
          _getContent(),
        ],
      ),
    );
  }

  Widget _getContent() {
    String qrSeedValue = 'Seed Value: ${_qrSeed.seed}';

    Widget mainCol = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(qrSeedValue, style: TextStyle(fontSize: 25)),
        QrImage(
          data: qrSeedValue,
          version: QrVersions.auto,
          size: 200.0,
        ),
        CountDownAnimatedWidget(
          animation: new StepTween(
            begin: kStartValue,
            end: 0,
          ).animate(_animationController),
        ),
        _getTimerToggleButton()
      ],
    );

    return Center(
      child: mainCol
    );
  }

  Widget _getTimerToggleButton() {
    String toggleTimerText =
        (_animationController.isAnimating) ? "Stop Timer" : "Resume Timer";

    return RaisedButton(
      color: Colors.white,
      child: Text(
        toggleTimerText,
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
      onPressed: () {
        log.i('pressed toggleTimer');
        if (_animationController.isAnimating) {
          _animationController.stop();
          setState(() {});
        } else {
          // start timer
          _animationController.forward();
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _qrSeedBloc.dispose();
    super.dispose();
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
