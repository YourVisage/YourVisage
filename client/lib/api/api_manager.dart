import 'package:client/api/api_helper.dart';
import 'package:client/api/htpp_path.dart';
import 'package:client/api/http_utils.dart';
import 'package:client/model/fake_detect_model.dart';
import 'package:client/model/image_picker_modal.dart';

class ApiManager {
  static Future<SwapImageResponse> swappingImage(
      SwapImageRequest request) async {
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
}
