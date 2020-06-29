import 'package:qr_code_demo/view/qrAppHome.dart';
import 'package:qr_code_demo/view/qrScanner.dart';
import 'package:qr_code_demo/view/expiringQrCode.dart';

class AppRoutes {

  static const String AppHome = 'AppHome';
  static const String QrScanner = 'QrScanner';
  static const String ExpiringQrCode = 'ExpiringQrCode';

  static String initialRoute() {
    return AppHome;
  }
  
  static getRouteMap() {
    
    return {
      AppRoutes.AppHome: (context) => AppHomeScreen(),
      AppRoutes.ExpiringQrCode: (context) => ExpiringQrCodeScreen(),
      AppRoutes.QrScanner: (context) => QrScannerScreen()
    };
    
  }
}