## Project Development Notes 

# Design Patterns

**BLoC/StreamBuilder** 
- For accessing the server.js endpoint using a StreamBuilder 
- Using routes.  See `lib/view/expiringQrCode.dart`

**Navigation Pattern**
- Using routes.  See `lib/app/appRoutes.dart`

# Flutter UI Components Demonstrated
- StreamBuilder 
- AnimatedWidget 

# Roadmap
1. Implement basic functionality for main features
2. Refactor to use MVVM/BLoC design pattern, using Flutter Streams
3. Fill in Test Automation for delivered code
     
# Implement basic functionality for main features

Flutter Client
- Scan QR Code
- Generate QR Code
- Connect to NodeJs Server endpoint 

NodeJs Server
-  Endpoint which generates a random seed used to create QR code

# How to Run Server

To run the server, you will need to have a local development environment set up with NodeJS.  Please let me know if you need additional details on this.

1. Open a command terminal

2. Navigate to the `/_nodeJsServer` folder under this project

3. Run the following commands:
 - `npm install`
 - `node server.js`


# Test Automation

Implemented `class TestNavUtil`
- See `lib/util/testNavUtil.dart`
- Used by `test/app_home_screen_widget_tests.dart`

Benefits are
 - Allows to better distill actual *business-logic* testing into clean concise test code
  
 - Reusable code across test files, this includes:
 * pop navigation
 * loading a screen with `WidgetTester`
 * encapsulation for `MockNavigatorObserver` 


