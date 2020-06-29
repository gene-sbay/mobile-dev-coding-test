import 'dart:async';

import 'package:qr_code_demo/model/qrSeed.dart';
import 'package:qr_code_demo/network/apiProvider.dart';

class QrSeedRepository {
  ApiProvider _apiProvider = ApiProvider();

  static const String ACTION_NEXT_SEED = 'nextSeed';

  Future<QrSeed> fetchNextSeedData() async {
    final response = await _apiProvider.get(ACTION_NEXT_SEED);
    return QrSeed.fromJson(response);
  }
}
