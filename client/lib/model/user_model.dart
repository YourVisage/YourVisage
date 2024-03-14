import 'package:client/api/base_request.dart';
import 'package:client/api/base_response.dart';

class SignInRequest extends BaseRequest {
  String? name;
  String? email;
  String? password;
  String? repassword;
  String? imageUrl;

  SignInRequest({
    this.name,
    this.email,
    this.password,
    this.repassword,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['repassword'] = this.repassword;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class SignInResponse extends BaseResponse {
  String? id;
  String? email;
  String? name;

  SignInResponse({
    this.id,
    this.email,
    this.name,
  });

  SignInResponse.fromJson(dynamic json) {
    parseBaseParams(json);
    id = json['uid'];
    email = json['email'];
    name = json['name'];
  }
}
