import 'dart:async';
import 'dart:io';

import 'package:client/api/api_helper.dart';
import 'package:client/api/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Global api caller
HttpUtils httpUtils = HttpUtils();

class HttpUtils {
  Dio _client = Dio();
  final logger = Logger('Api');

  HttpUtils() {
    init(url: ApiHelper.baseUrl, isInit: true);
  }

  /// Main HTTP request
  FutureOr<dynamic> sendRequest({
    /// Base
    String url = ApiHelper.baseUrl,
    required String path,
    String httpMethod = HttpMethod.post,
    Map<String, String>? headers,
    bool hasAuthorization = true,

    /// Data
    String dataType = DataType.Object,
    dynamic objectData, //  POST - Class model
    dynamic dynamicData, // String, num
    Map<String, String>? queryParameters, // GET
  }) async {
    /// Response
    var requestOptions = RequestOptions(path: path);
    Response response = Response(requestOptions: requestOptions);
    Map<String, dynamic> responseData = initResponseData();

    logger.func = httpMethod;

    try {
      /// Headers
      headers ??= ApiHelper.getHttpHeaders();
      _client.options.headers = headers;
      if (!hasAuthorization) _client.options.headers.remove('authorization');

      /// Url
      _client.options.baseUrl = url;
      // _client.options.receiveTimeout = Duration(milliseconds: 0000);
      // _client.options.connectTimeout = Duration(milliseconds: 30000);
      _client.options.followRedirects = false;

      print("options:${_client.options.connectTimeout}");

      /// Request data
      dynamic requestBody;

      switch (dataType) {
        case DataType.Object:
          requestBody = objectData?.toJson();
          break;

        case DataType.Empty:
          requestBody = <Map<String, dynamic>>[]; // Empty list. Example: []
          break;

        case DataType.Int:
        case DataType.Str:
          requestBody = <dynamic>[]; // Dynamic list. Example: [11, "12"]
          if (dynamicData != null) requestBody.add(dynamicData);
          break;

        case DataType.List:
          var dataList = (dynamicData != null) ? dynamicData : []; // Dynamic list. Example: [11, "12"]
          requestBody = dataList;
          break;
        case DataType.FormData:
          requestBody = objectData;
          break;

        default:
          requestBody = (objectData != null) ? objectData.toJson() : <Map<String, dynamic>>[];
      }

      /// Send request
      switch (httpMethod) {
        case HttpMethod.get:
          response = await _client.get(path, queryParameters: queryParameters);
          break;
        case HttpMethod.put:
          response = await _client.put(path, data: requestBody);
          break;
        case HttpMethod.delete:
          response = await _client.delete(path, data: requestBody);
          break;
        case HttpMethod.post:
        default:
          response = await _client.post(path, data: requestBody);
          break;
      }

      /// Response
      logger.log(s: 3, m: response);
      if (response.statusCode == ResponseCode.Success) {
        /// SUCCESS
        logger.log(s: 4);

        // Manage response
        responseData[ResponseParam.code] = ResponseCode.Success;
        if (response.data == null) {
          // Empty
        } else if (response.data is String || response.data is int) {
          responseData[ResponseParam.data] = response.data; // Str, int
        } else if (response.data is Map<String, dynamic>) {
          responseData.addAll(response.data); // JSON object
        } else {
          responseData[ResponseParam.data] = response.data; // Other response, JSON array etc
        }
      } else {
        /// FAILED
        responseData[ResponseParam.code] = ResponseCode.Error;
        if (response.data is Map<String, dynamic>) {
          responseData[ResponseParam.data] = response.data; // Str, int
        }
        logger.log(s: 5, m: response);
      }
    } on DioError catch (error) {
      /// FAILED

      logger.log(s: 10, m: 'DioError Exception: $error');
      responseData[ResponseParam.code] = error.response?.statusCode;
      responseData[ResponseParam.message] = ApiHelper.getErrorMessage(ResponseCode.Failed, error.message);

      if (error.type == DioErrorType.connectionTimeout) {
        // Request timeout
        responseData[ResponseParam.code] = ResponseCode.RequestTimeout;
        responseData[ResponseParam.message] = ApiHelper.getErrorMessage(ResponseCode.RequestTimeout, error.message);
      } else if (error.response?.statusCode == ResponseCode.Error) {
        // 422 Error
        responseData[ResponseParam.code] = error.response?.statusCode;
        responseData[ResponseParam.message] = error.response?.data['error'];
      } else if (error.response?.statusCode == ResponseCode.NotFound) {
        // 404 Bad Request
        responseData[ResponseParam.code] = error.response?.statusCode;
        responseData[ResponseParam.message] = error.response?.data['error'];
      } else if (error.response?.statusCode == ResponseCode.BadRequest) {
        // 400 Bad Request
        responseData[ResponseParam.code] = error.response?.statusCode;
        responseData[ResponseParam.message] = error.response?.data['error'];
      } else if (error.response != null) {
        // Normal response
        response = error.response!;
        if (response.data != null && response.data is Map<String, dynamic>) {
          try {
            responseData[ResponseParam.code] = error.response?.data['StatusCode'];
            responseData[ResponseParam.message] = error.response?.data['Message'];
          } catch (e) {
            print(e);
          }
        }
      }

      /// Session timeout
      try {
        if (error.response?.statusCode == ResponseCode.Unauthorized) {}
      } catch (e) {
        print(e);
      }
    } catch (error, stacktrace) {
      print(error);
      logger.log(s: 11, m: 'Exception occured: $error stackTrace: $stacktrace');
      responseData[ResponseParam.code] = ResponseCode.Failed;
      responseData[ResponseParam.message] = ApiHelper.getErrorMessage(ResponseCode.Failed, error);
    } finally {
      response.data = responseData;
    }

    return response.data;
  }

  void init({
    required String url,
    bool isInit = false, // URL өөрчлөгдсөн бол client-ийг дахин тодорхойлно
  }) async {
    /// Main http client
    logger.func = '_internal';
    logger.log(s: 1);

    BaseOptions options = BaseOptions(
      responseType: ResponseType.json,
      receiveTimeout: Duration(milliseconds: 30000),
      connectTimeout: Duration(milliseconds: 30000),
      followRedirects: false,
      receiveDataWhenStatusError: true,
    );
    options.baseUrl = ApiHelper.baseUrl; // + ApiHelper.basePath;
    // options.contentType =
    //     Headers.jsonContentType; //ContentType.parse("application/json");
    //options.contentType= ContentType.parse("application/x-www-form-urlencoded");
    options.headers = ApiHelper.getHttpHeaders();
//      _client.httpClientAdapter

    _client = Dio(options);
    _client.interceptors
        // ..add(CookieManager(CookieJar()))
        .add(LogInterceptor(requestBody: true, responseBody: true));

    (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Map<String, dynamic> initResponseData() {
    return <String, dynamic>{}
      ..putIfAbsent(ResponseParam.code, () => ResponseCode.Failed)
      ..putIfAbsent(ResponseParam.message, () => '')
      ..putIfAbsent(ResponseParam.data, () => null);
  }
}

/// HTTP request-ийн дамжуулах өгөгдлийн төрөл
class DataType {
  static const String Object = 'Object'; // Class model
  static const String Empty = 'Empty';
  static const String Str = 'Str';
  static const String Int = 'Int';
  static const String List = 'List';
  static const String FormData = 'FormData';
}
