import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2ray/core/constants/const.dart';

class MyPreferences {
  // Initializes SharedPreferences
  static Future<SharedPreferences> _initPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // Write methods (Setters)
  static Future<void> setIsUserLoggedIn({required bool isLoggedIn}) async {
    final preferences = await _initPreferences();
    preferences.setBool(Const.isLoggedIn, isLoggedIn);
  }

  static Future<void> setUserPhoneNumber({required String phoneNumber}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.userPhoneNumber, phoneNumber);
  }

  static Future<void> setUserPassword({required String password}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.userPassword, password);
  }

  static Future<void> setUserToken({required String token}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.userToken, token);
  }

  static Future<void> setSelectedServerIndex({required int index}) async {
    final preferences = await _initPreferences();
    preferences.setInt(Const.selectedServerIndex, index);
  }

  static Future<void> setCountryNameAndImage({required String countryNameAndImage}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.countryName, countryNameAndImage);
  }

  static Future<void> setStartServiceDate({required String startServiceDate}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.startServiceDate, startServiceDate);
  }

  static Future<void> setEndServiceDate({required String endServiceDate}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.endServiceDate, endServiceDate);
  }

  static Future<void> setUserName({required String userName}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.userName, userName);
  }

  static Future<void> setSelectedServerAddress({required String serverAddress}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.selectedServerAddress, serverAddress);
  }

  static Future<void> setMultiUserDevices({required String multiUserDevices}) async {
    final preferences = await _initPreferences();
    preferences.setString(Const.devices_multiUser, multiUserDevices);
  }

  static Future<void> setAppTunnels({required List<String> appsTunnel}) async {
    final preferences = await _initPreferences();
    preferences.setStringList(Const.appTunnels, appsTunnel);
  }

  // Read methods (Getters)
  static Future<bool> getIsUserLoggedIn() async {
    final preferences = await _initPreferences();
    return preferences.getBool(Const.isLoggedIn) ?? false;
  }

  static Future<String?> getUserPhoneNumber() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.userPhoneNumber);
  }

  static Future<String?> getUserPassword() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.userPassword);
  }

  static Future<String?> getUserToken() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.userToken);
  }

  static Future<int?> getSelectedServerIndex() async {
    final preferences = await _initPreferences();
    return preferences.getInt(Const.selectedServerIndex);
  }

  static Future<String?> getSelectedServerAddress() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.selectedServerAddress);
  }

  static Future<String?> getCountryNameAndImage() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.countryName);
  }

  static Future<List<String>?> getAppTunnels() async {
    final preferences = await _initPreferences();
    return preferences.getStringList(Const.appTunnels);
  }

  static Future<String?> getStartServiceDate() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.startServiceDate);
  }

  static Future<String?> getEndServiceDate() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.endServiceDate);
  }

  static Future<String?> getMultiUserDevices() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.devices_multiUser);
  }

  static Future<String?> getUserName() async {
    final preferences = await _initPreferences();
    return preferences.getString(Const.userName);
  }
}
