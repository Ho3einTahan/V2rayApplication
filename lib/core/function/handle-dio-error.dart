import 'package:dio/dio.dart';

import '../../utils/api_exceptions.dart';

ApiException handleDioError(dynamic e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return ApiException(message: 'اتصال به سرور برقرار نشد. لطفاً دوباره تلاش کنید.', code: 408);
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return ApiException(message: 'پاسخی از سمت سرور دریافت نشد. لطفاً دوباره تلاش کنید.', code: 504);
    }

    if (e.response != null) {
      int statusCode = e.response!.statusCode ?? 500;
      String serverMessage = e.response!.data['message'] ?? 'خطای ناشناخته از سمت سرور';

      switch (statusCode) {
        case 400:
          return ApiException(message: serverMessage, code: 400);
        case 401:
          return ApiException(message: serverMessage, code: 401);
        case 403:
          return ApiException(message: serverMessage, code: 403);
        case 404:
          return ApiException(message: serverMessage, code: 404);
        case 500:
        default:
          return ApiException(message: serverMessage, code: statusCode);
      }
    } else {
      return ApiException(message: 'هیچ پاسخی از سمت سرور دریافت نشد. اتصال اینترنت خود را بررسی کنید.', code: 500);
    }
  } else {
    return ApiException(message: 'خطای ناشناخته: ${e.toString()}', code: 500);
  }
}
