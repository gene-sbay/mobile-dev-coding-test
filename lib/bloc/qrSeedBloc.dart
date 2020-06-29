import 'dart:async';

import 'package:qr_code_demo/model/qrSeed.dart';
import 'package:qr_code_demo/network/apiResponse.dart';
import 'package:qr_code_demo/repository/qrSeedRepository.dart';

class QrSeedBloc {
  QrSeedRepository _qrSeedRepository;

  StreamController _qrSeedDataController;

  StreamSink<ApiResponse<QrSeed>> get qrSeedDataSink =>
      _qrSeedDataController.sink;

  Stream<ApiResponse<QrSeed>> get qrSeedDataStream =>
      _qrSeedDataController.stream;

  QrSeedBloc() {
    _qrSeedRepository = QrSeedRepository();
    _qrSeedDataController = StreamController<ApiResponse<QrSeed>>();
    fetchNextSeed();
  }

  fetchNextSeed() async {

    print ('enter fetchNextSeed()');

    try {
      QrSeed nextQrSeed = await _qrSeedRepository.fetchNextSeedData();
      print('nextQrSeed: $nextQrSeed');

      qrSeedDataSink.add(ApiResponse.completed(nextQrSeed));
    } catch (e) {
      qrSeedDataSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _qrSeedDataController?.close();
  }
}

// StreamController _randomSeedListController;
//  StreamSink<ApiApiResponse<RandomSeed>> get qrSeedListSink =>
//      _randomSeedListController.sink;
//  Stream<ApiApiResponse<RandomSeed>> get qrSeedListStream =>
//      _randomSeedListController.stream;
