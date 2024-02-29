// Model class for the request payload
import 'package:client/api/base_request.dart';
import 'package:client/api/base_response.dart';

class SwapImageRequest extends BaseRequest {
  String? faceToSwap;
  String? realImage;

  SwapImageRequest({
    this.faceToSwap,
    this.realImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'face_to_swap': faceToSwap,
      'real_image': realImage,
    };
  }
}

class SwapImageResponse extends BaseResponse {
  String? resultImage;

  SwapImageResponse({required this.resultImage});

  SwapImageResponse.fromJson(dynamic json) {
    parseBaseParams(json);
    resultImage = json['resultImage'];
  }
}
