
    import 'package:flutter/material.dart';
    import 'package:flutter_test/flutter_test.dart';
    import 'package:mockito/mockito.dart';
    import 'package:qr_code_demo/app/appRoutes.dart';
    import 'package:qr_code_demo/view/appHome.dart';
    import 'package:qr_code_demo/view/qrScanner.dart';

    class MockNavigatorObserver extends Mock implements NavigatorObserver {}

    void main() {
      group('MainPage navigation tests', () {
        NavigatorObserver mockObserver;

        _loadAppHomeScreen(WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              routes: AppRoutes.getRouteMap(),
              home: AppHomeScreen(),
              navigatorObservers: [mockObserver],
            ),
          );
        }

        setUp(() {
          mockObserver = MockNavigatorObserver();
        });

        Future<Null> _verifyLayoutElements(WidgetTester tester) async {
          print('_verifyLayoutElements');
          expect(find.byIcon(Icons.scanner), findsOneWidget);
          expect(find.byType(FloatingActionButton), findsOneWidget);
          expect(find.byType(RaisedButton), findsOneWidget);
        }

        Future<Null> _navigateToQrScannerScreen(WidgetTester tester) async {
          print('_navigateToQrScannerScreen');

          await tester.tap(find.byIcon(Icons.scanner));
          await tester.pumpAndSettle();

          verify(mockObserver.didPush(any, any));

          expect(find.byType(AppHomeScreen), findsNothing);
          expect(find.byType(QrScannerScreen), findsOneWidget);
        }

        testWidgets('AppHomeScreen WidgetTester', (WidgetTester tester) async {
          await _loadAppHomeScreen(tester);

          await _verifyLayoutElements(tester);
          await _navigateToQrScannerScreen(tester);
        });
      });
    }
