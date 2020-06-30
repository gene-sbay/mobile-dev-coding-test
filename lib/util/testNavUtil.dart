import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_code_demo/app/appRoutes.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestNavUtil {

  NavigatorObserver _mockObserver;

  TestNavUtil() {
    _mockObserver = MockNavigatorObserver();
  }

  NavigatorObserver get mockObserver => _mockObserver;

  popWidgetTester(WidgetTester tester) async {
    final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
    await widgetsAppState.didPopRoute();
  }

  loadAppScreen(WidgetTester tester, Widget screenWidget) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: AppRoutes.getRouteMap(),
        home: screenWidget,
        navigatorObservers: [_mockObserver],
      ),
    );
  }

}
