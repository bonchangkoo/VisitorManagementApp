import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  // Save Credentials
  Future saveCredentials(AccessCredentials credentials) async {
    final token = credentials.accessToken;
    await _storage.write(key: "type", value: token.type);
    await _storage.write(key: "data", value: token.data);
    await _storage.write(key: "expriy", value: token.expiry.toIso8601String());
    await _storage.write(key: "refreshToken", value: credentials.refreshToken);
  }

  // Get Saved Credentials
  Future<AccessCredentials> getCredentials(List<String> scopes) async {
    final result = await _storage.readAll();
    if (result.isEmpty) return null;
    return AccessCredentials(
        AccessToken(
            result["type"],
            result["data"],
            DateTime.parse(result["expriy"])
        ),
        result["refreshToken"],
        scopes
    );
  }

  // Save SheetInfo
  Future saveSheetInfo(String sheetId) async {
    await _storage.write(key: "sheetId", value: sheetId);
  }

  // Get Saved SheetInfo
  Future<String> getSheetId() async {
    return _storage.read(key: "sheetId");
  }

  // Clear saved Credentials
  Future clear() {
    return _storage.deleteAll();
  }
}