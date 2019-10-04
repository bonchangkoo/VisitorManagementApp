import 'dart:async';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class GoogleSheetController {

  factory GoogleSheetController() {
    return INSTANCE;
  }

  GoogleSheetController._innerConstructor();
  static GoogleSheetController INSTANCE = GoogleSheetController._innerConstructor();

  final _streamController = StreamController<String>();

  final _SCOPES = const [SheetsApi.SpreadsheetsScope];
  final _clientId = ClientId('863738001853-pvigji6dbovcg42ii1o22msffp8acbvf.apps.googleusercontent.com', 'P6-7q1ywRn6E43g9a6VsNfb1');

  Future<http.Client> _httpClient() async {
    final AuthClient authClient = await clientViaUserConsent(_clientId, _SCOPES, (url) {
      launch(url);
    });
    return authClient;
  }
  Stream<String> get urlStream => _streamController.stream;



  void requestSheetInfo() async {
    http.Client client = await _httpClient();
    Spreadsheet sheet = await SheetsApi(client).spreadsheets.get('1ztkYwM6Kz0F8X-PcksSqStdbMqpvh1B55Wo81nmd5t4');
    for (Sheet s in sheet.sheets) {
      print("==> $s.");
    }
    client.close();
  }

  void close() {
    _streamController.close();
  }

}