import 'package:flutter/services.dart';

class SheetApiClient {
  static const googleSheetApiNative = const MethodChannel('kr.co.deliveryhero/GoogleSheetApi');
  bool isInitialized = false;

  SheetApiClient(SheetApiParam param) {
//    try {
//      googleSheetApiNative.invokeMethod("setup", param).then((result) {
//        isInitialized = true;
//      });
//    } on PlatformException catch(e) {
//      print("@## GoogleSheetApi Setup Failed\n${e.message}");
//    }
  }

  void write(Record record) {
    // TODO
  }

  void read(String row, String column) {

  }

}

class SheetApiParam {
  String googleApiKey;
  String spreadsheetId;
}

class Cell {
  String column;
  String row;
  String data;
}

class Record {
  List<Cell> cells = <Cell>[];
}