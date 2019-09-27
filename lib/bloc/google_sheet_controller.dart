import 'dart:async';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class GoogleSheetController {

  factory GoogleSheetController() {
    return INSTANCE;
  }

  GoogleSheetController._innerConstructor();
  static GoogleSheetController INSTANCE = GoogleSheetController._innerConstructor();

  final _streamController = StreamController<String>();
  final _httpClient = http.Client();
  Stream<String> get urlStream => _streamController.stream;

  final _SCOPES = const [SheetsApi.SpreadsheetsScope];
  final _clientId = ClientId('863738001853-pvigji6dbovcg42ii1o22msffp8acbvf.apps.googleusercontent.com', 'P6-7q1ywRn6E43g9a6VsNfb1');

  void requestCertificate() {
    obtainAccessCredentialsViaUserConsent(_clientId, _SCOPES, _httpClient, onReceivedPrompt)
        .catchError((Exception e) {
          _streamController.sink.addError(e);
        }).then((accessCredentials) {
          onReceiveAuthenticatedClient(authenticatedClient(_httpClient, accessCredentials));
        });
  }

  void onReceiveAuthenticatedClient(AuthClient authClient) {
    SheetsApi(authClient, );
  }

  void onReceivedPrompt(String url) {
    print("@## =>> $url");
    _streamController.sink.add(url);
  }

  void close() {
    _streamController.close();
    _httpClient.close();
  }

}