import 'package:device_information/device_information.dart';

class ImeiManager{
  Future<String> getDeviceIMEINumber() async {
    try {
      return await DeviceInformation.deviceIMEINumber;
    } catch (e) {
      return '';
    }
  }
}