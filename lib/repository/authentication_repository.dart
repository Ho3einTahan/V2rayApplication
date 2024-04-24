import 'package:dartz/dartz.dart';
import 'package:v2ray/datasource/authentication_datasource.dart';
import 'package:v2ray/di/di.dart';

import '../utils/api_exceptions.dart';

abstract class IAuthRepository {
  Future<Either<String, Map<String,dynamic>>> login(String phoneNumber, String macAddress);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();

  @override
  Future<Either<String, Map<String,dynamic>>> login(
      String phoneNumber, String macAddress) async {
    try {
      Map<String,dynamic> response = await _datasource.login(phoneNumber, macAddress);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    } catch (e) {
      return left(e.toString() ?? 'خطایی رخ داد');
    }
  }
}
