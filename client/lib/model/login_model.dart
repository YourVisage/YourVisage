import 'package:client/api/base_request.dart';
import 'package:client/api/base_response.dart';

class LoginUserRequest extends BaseRequest {
  String? email;

  LoginUserRequest({
    this.email,
  });

  LoginUserRequest.toJson(Map<String, dynamic> json) {
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class LoginUserResponse extends BaseResponse {
  String? accessToken;
  String? tokenType;

  LoginUserResponse({this.accessToken, this.tokenType});

  LoginUserResponse.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }
}
