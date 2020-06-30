
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_code_demo/util/testNavUtil.dart';
import 'package:qr_code_demo/app/appRoutes.dart';
import 'package:qr_code_demo/view/appHome.dart';
import 'package:qr_code_demo/view/qrScanner.dart';
import 'package:qr_code_demo/view/expiringQrCode.dart';

void main() {
  TestNavUtil _navUtil = TestNavUtil();

  group('AppHomeScreen layout & navigation tests', () {

    setUp(() {
    });

    Future<Null> _verifyLayoutElements(WidgetTester tester) async {
      print('_verifyLayoutElements');

      await _navUtil.loadAppScreen(tester, AppHomeScreen());

      expect(find.byIcon(Icons.scanner), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    }

    Future<Null> _navigateToQrScannerScreen(WidgetTester tester) async {
      print('_navigateToQrScannerScreen');

      await _navUtil.loadAppScreen(tester, AppHomeScreen());

      await tester.tap(find.byIcon(Icons.scanner));
      await tester.pumpAndSettle();

      verify(_navUtil.mockObserver.didPush(any, any));

      expect(find.byType(AppHomeScreen), findsNothing);
      expect(find.byType(QrScannerScreen), findsOneWidget);
    }

    Future<Null> _navigateToExpiringQrCodeScreen(WidgetTester tester) async {
      print('_navigateToExpiringQrCodeScreen');

      await _navUtil.loadAppScreen(tester, AppHomeScreen());

      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();

      verify(_navUtil.mockObserver.didPush(any, any));

      expect(find.byType(AppHomeScreen), findsNothing);
      expect(find.byType(ExpiringQrCodeScreen), findsOneWidget);
    }

    testWidgets('AppHomeScreen WidgetTester', (WidgetTester tester) async {

      await _verifyLayoutElements(tester);
      await _navigateToQrScannerScreen(tester);

      await _navUtil.popWidgetTester(tester);

      await _navigateToExpiringQrCodeScreen(tester);
    });
  });
}
