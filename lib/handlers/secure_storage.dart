import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  var storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() {
    return storage.read(key: "AccessToken");
  }

  Future<String?> getRefreshToken() {
    return storage.read(key: "RefreshToken");
  }

  writeAccessToken(String accessToken) async {
    await storage.write(key: "AccessToken", value: accessToken);
  }

  writeRefreshToken(String refeshToken) async {
    await storage.write(key: "RefreshToken", value: refeshToken);
  }

  deleteAccessToken() async {
    await storage.delete(key: "AccesToken");
  }

  deleteRefreshToken() async {
    await storage.delete(key: "RefreshToken");
  }
}
