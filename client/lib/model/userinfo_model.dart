import 'package:client/api/base_response.dart';

class UserinfoResponse extends BaseResponse {
  String? password;
  String? email;
  String? repassword;
  String? name;

  UserinfoResponse({this.password, this.email, this.repassword, this.name});

  UserinfoResponse.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);
    password = json['password'];
    email = json['email'];
    repassword = json['repassword'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['email'] = this.email;
    data['repassword'] = this.repassword;
    data['name'] = this.name;
    return data;
  }
}
