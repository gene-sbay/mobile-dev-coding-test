import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:qr_code_demo/network/customException.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String DESKTOP_LOCALHOST = '10.0.2.2:8000';
  static const String REST_SERVER = 'http://$DESKTOP_LOCALHOST';

  Future<dynamic> get(String restAction) async {
    String requestUrl = '$REST_SERVER/$restAction';

    print('requestUrl: $requestUrl');

    var responseJson;
    try {
      final response = await http.get(requestUrl);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
