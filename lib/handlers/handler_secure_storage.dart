import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  var storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() {
    return storage.read(key: "AccessToken");
  }

  Future<String?> getRefreshToken() {
    return storage.read(key: "RefreshToken");
  }

  Future<String?> getCurrentSelectedGame() {
    return storage.read(key: 'CurrentGame');
  }

  Future<String?> getCurrentSelectedArea() {
    return storage.read(key: 'CurrentArea');
  }

  writeAccessToken(String accessToken) async {
    await storage.write(key: "AccessToken", value: accessToken);
  }

  writeRefreshToken(String refeshToken) async {
    await storage.write(key: "RefreshToken", value: refeshToken);
  }

  writeCurrentGame(String currentGameID) async {
    await storage.write(key: "CurrentGame", value: currentGameID);
  }

  writeCurrentArea(String currentArea) async {
    await storage.write(key: "CurrentArea", value: currentArea);
  }

  deleteAccessToken() async {
    await storage.delete(key: "AccesToken");
  }

  deleteRefreshToken() async {
    await storage.delete(key: "RefreshToken");
  }

  deleteCurrentGame() async {
    await storage.delete(key: "CurrentGame");
  }

  deleteCurrentArea() async {
    await storage.delete(key: "CurrentArea");
  }
}
