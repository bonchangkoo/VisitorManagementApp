import 'dart:async';
import 'package:dhk_visitor_management_app/util/secure_storage.dart';
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
  Stream<String> get urlStream => _streamController.stream;

  final _SCOPES = const [SheetsApi.SpreadsheetsScope];
  final _clientId = ClientId('863738001853-pvigji6dbovcg42ii1o22msffp8acbvf.apps.googleusercontent.com', 'P6-7q1ywRn6E43g9a6VsNfb1');
  final _storage = SecureStorage();

  Future<http.Client> _getAuthClient() async {
    final credentials = await _storage.getCredentials(_SCOPES);
    if (credentials == null) {
      final AuthClient authClient = await clientViaUserConsent(
          _clientId, _SCOPES, (url) {
        launch(url);
      });
      _storage.saveCredentials(authClient.credentials);
      return authClient;
    } else {
      return authenticatedClient(http.Client(), credentials);
    }
  }


  void requestSheetInfo(String visitDate, String residenceTime, String visitorName, String visitorCompany, String visitPurpose, String visitDepartment, String welcomerName) async {
    http.Client client = await _getAuthClient();
    SheetsApi api = SheetsApi(client);

    ValueRange vr = new ValueRange.fromJson({
      "values": [
        [ // fields A - G
          visitDate, residenceTime, visitorName, visitorCompany, visitPurpose, visitDepartment, welcomerName
        ]
      ]
    });
    api.spreadsheets.values
        .append(vr, '1-opthJwZt8LiYqozGS5TlHE-n_YsDO9T_kzgN9kwMS0', 'A:G',
        valueInputOption: 'USER_ENTERED')
        .then((AppendValuesResponse r) {
      print('==> append completed.');
    });
    client.close();
  }

  void setSheetId(String sheetId) async {
    _storage.saveSheetInfo(sheetId);
  }

  void write(Map<String, dynamic> data) {

  }

  void close() {
    _streamController.close();
  }

}