import 'package:client/api/api_helper.dart';
import 'package:client/api/htpp_path.dart';
import 'package:client/api/http_utils.dart';
import 'package:client/model/fake_detect_model.dart';
import 'package:client/model/image_picker_modal.dart';
import 'package:client/model/login_model.dart';
import 'package:client/model/user_model.dart';
import 'package:client/model/userinfo_model.dart';

class ApiManager {
  static Future<SwapImageResponse> swappingImage(SwapImageRequest request) async {
    print(request);
    var res = SwapImageResponse.fromJson(await httpUtils.sendRequest(
      path: HttpPath.faceSwap,
      objectData: request,
      httpMethod: HttpMethod.post,
    ));
    return res;
  }

  static Future<DetectModal> detectImage(DetectModelRequest request) async {
    var res = DetectModal.fromJson(await httpUtils.sendRequest(
      path: HttpPath.detectAi,
      objectData: request,
      httpMethod: HttpMethod.post,
    ));
    return res;
  }

  static Future<SignInResponse> register(SignInRequest request) async {
    var res = SignInResponse.fromJson(await httpUtils.sendRequest(
      path: HttpPath.create,
      objectData: request,
      httpMethod: HttpMethod.post,
      hasAuthorization: false,
    ));
    return res;
  }

  static Future<UserinfoResponse> userInfo(String id) async {
    var res = UserinfoResponse.fromJson(await httpUtils.sendRequest(
      path: '${HttpPath.getUserInfo}/$id',
      httpMethod: HttpMethod.get,
    ));
    return res;
  }

  static Future<LoginUserResponse> loginUser(LoginUserRequest request) async {
    var res = LoginUserResponse.fromJson(await httpUtils.sendRequest(
      path: HttpPath.login,
      httpMethod: HttpMethod.post,
      hasAuthorization: false,
      objectData: request,
    ));
    return res;
  }
}
