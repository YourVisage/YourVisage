import 'dart:io';

import 'package:client/api/base_request.dart';
import 'package:client/api/base_response.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class DetectionModalResponse extends BaseResponse {
  String? aiGenerated;
  double? confidenceScore;

  DetectionModalResponse({this.aiGenerated, this.confidenceScore});

  DetectionModalResponse.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);
    aiGenerated = json['class'];
    confidenceScore = json['confidence_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.aiGenerated;
    data['confidence_score'] = this.confidenceScore;
    return data;
  }
}

class DetectionModalRequest extends BaseRequest {
  File? image;

  FormData toFormData() {
    FormData formData = FormData();
    if (image != null) {
      formData.files.add(MapEntry(
        'image',
        MultipartFile.fromFileSync(image!.path, filename: 'image.jpg'),
      ));
    }
    return formData;
  }
}
