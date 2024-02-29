import 'package:client/api/api_helper.dart';
import 'package:client/helpers/func.dart';

class BaseResponse {
  int? code;
  String? message;
  dynamic data;

  BaseResponse([this.code, this.message, this.data]);

  BaseResponse.fromJson(Map<String, dynamic> json)
      : code = json[ResponseParam.code] ?? ResponseCode.Failed,
        message = json[ResponseParam.message],
        data = json[ResponseParam.data];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[ResponseParam.code] = code;
    data[ResponseParam.message] = message;
    data[ResponseParam.data] = this.data;

    return data;
  }

  void parseBaseParams(Map<String, dynamic> json) {
    code = json[ResponseParam.code];
    message = json[ResponseParam.message];
    data = json;
  }

  @override
  String toString() {
    return '''BaseResponse {
      ${ResponseParam.code}: $code,
      ${ResponseParam.message}: $message,
      ${ResponseParam.data}: $data,
    }''';
  }
}

class ResponseHelper {
  static const code = 'code';
  static const message = 'message';
  static const data = 'data';

  static String getFailedDesc(String desc) {
    if (Func.isNotEmpty(desc)) {
      return desc;
    } else {
      return 'Error';
    }
  }
}
