import 'package:client/helpers/func.dart';

class ApiHelper {
  // static const String baseUrl = 'http://192.168.2.52:3333/'; // Test/
  static const String baseUrl = 'http://192.168.1.249:8000/'; // Production/
  // static const String baseUrl = 'http://192.168.1.209:3000/'; // Local/

  static Map<String, String> getHttpHeaders() {
    var headers = <String, String>{};
    headers.addAll({
      'Connection': 'Close',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    return headers;
  }

  static String getErrorMessage(int errCode, [Object? error]) {
    String message = 'Алдаа гарлаа: $errCode';
    // print(error.message);

    switch (errCode) {
      case ResponseCode.Failed:
        message = 'Та интернэт холболтоо шалган дахин оролдоно уу ';
        break;

      case ResponseCode.RequestTimeout:
        message = 'Та интернэт холболтоо шалган дахин оролдоно уу ';
        break;

      case ResponseCode.BadRequest:
        message = 'Интернэт холболтоо шалгана уу!';
        break;
    }
    return message;
  }

  static String getFailedMessage(String? message) {
    return Func.isNotEmpty(message) ? message! : 'Error';
  }
}

class ResponseParam {
  static const code = 'code';
  static const message = 'message';
  static const data = 'data';

  static String getFailedMessage(String message) {
    return Func.isNotEmpty(message) ? message : 'Error';
  }
}

/// HTTP response codes
class ResponseCode {
  // 1xx Informational
  static const Continue = 100;

  // 2xx Success
  static const OK = 200; // Request is successfully completed.

  // 3xx Redirection
  static const MultipleChoices = 300;

  // 4xx Client error
  static const Failed = 4;
  static const NoData = 40;
  static const BadRequest = 400; // No internet
  static const Unauthorized = 401; // We could not recognize you.
  static const Forbidden = 403; // Access to the requested resource or action is forbidden.
  static const NotFound = 404; // The requested resource could not be found.
  static const RequestTimeout = 408;
  static const Error = 422;

  // 5xx Server error
  static const InternalServerError = 500; // We had a problem with our server. Try again later.
  static const ServiceUnavailable = 503; // We're temporarily offline for maintenance. Please try again later.

  /// Business response codes
  static const Success = 200;
  static const ChangePass = 91001008; // Нууц үгээ солино уу
  static const SerializeError = 999; // json serializeError
  static const SessionExpired = 91001018; // Нэвтэрнэ үү
}

class HttpMethod {
  static const post = 'POST';
  static const get = 'GET';
  static const put = 'PUT';
  static const delete = 'DELETE';
}
