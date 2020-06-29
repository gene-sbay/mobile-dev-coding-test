## Project Development Notes 

# Design Patterns

- **BLoC** : For accessing the server.js endpoint using a StreamBuilder 
- **Navigation Pattern**: Using routes.  See `lib/app/appRoutes.dart`

# Flutter Data Components Demonstrated

- StreamBuilder 

# Flutter UI Components Demonstrated

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
