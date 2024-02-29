import 'package:client/api/base_request.dart';
import 'package:client/api/base_response.dart';

class DetectModal extends BaseResponse {
  Request? request;
  Media? media;
  Type? type;
  String? status;

  DetectModal({this.request, this.media, this.type, this.status});

  DetectModal.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Request extends BaseResponse {
  String? id;
  double? timestamp;
  int? operations;

  Request({this.id, this.timestamp, this.operations});

  Request.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);

    id = json['id'];
    timestamp = json['timestamp'];
    operations = json['operations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['timestamp'] = this.timestamp;
    data['operations'] = this.operations;
    return data;
  }
}

class Media extends BaseResponse {
  String? uri;
  String? id;

  Media({this.uri, this.id});

  Media.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);
    uri = json['uri'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    data['id'] = this.id;
    return data;
  }
}

class Type extends BaseResponse {
  double? aiGenerated;

  Type({this.aiGenerated});

  Type.fromJson(Map<String, dynamic> json) {
    parseBaseParams(json);

    aiGenerated = json['ai_generated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ai_generated'] = this.aiGenerated;
    return data;
  }
}

class DetectModelRequest extends BaseRequest {
  String? uri;
  DetectModelRequest({this.uri});

  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
    };
  }
}
