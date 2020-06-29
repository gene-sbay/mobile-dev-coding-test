import 'package:flutter/material.dart';

class AppUi {
  static GestureDetector getClearFocusGestureDetector(
      BuildContext context, List<Widget> screenWidgets) {
    Column mainColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: screenWidgets);

    // to support touch listener , eg click outside of textfield to lose/take focus
    GestureDetector clearFocusGestureDetector = new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // print('GestureDetector.onTap()');
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: mainColumn);

    return clearFocusGestureDetector;
  }

  static Container getOrangeSodaGradientScreenContainer(
      BuildContext context, Widget mainLayoutContainerWidget) {
    Color gradientStart = Colors.orange[500];
    Color gradientEnd = Colors.orange[100];

    return getGradientScreenContainer(
        context, gradientStart, gradientEnd, mainLayoutContainerWidget);
  }

  static Container getGreenGradientScreenContainer(
      BuildContext context, Widget mainLayoutContainerWidget) {
    Color gradientStart = Colors.lightGreen[800];
    Color gradientEnd = Colors.lightGreen[200];

    return getGradientScreenContainer(
        context, gradientStart, gradientEnd, mainLayoutContainerWidget);
  }

  static Container getGradientScreenContainer(
      BuildContext context,
      Color gradientStart,
      Color gradientEnd,
      Widget mainLayoutContainerWidget) {
    // Holds main setup like background color, etc
    Container mainContainer = Container(
      padding: const EdgeInsets.only(top: 30, left: 10),
      // top is to dip below the status bar
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: mainLayoutContainerWidget,
    );

    return mainContainer;
  }
}

class CountDownAnimatedWidget extends AnimatedWidget {
  CountDownAnimatedWidget({Key key, this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 150.0),
    );
  }
}


/*

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
 */