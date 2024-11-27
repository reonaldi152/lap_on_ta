import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'network/interceptors/authorization_interceptor.dart';
import 'network/interceptors/logger_interceptor.dart';

final baseUrl = dotenv.env['BASEURL_STAGING']!;
// final baseUrl = dotenv.env['BASEURL_PRODUCTION']!;
// final baseUrl = "https://laravel4.isysedge.com/cashout/public/api/";

class Network {
  static Future<dynamic> postApi(String url, dynamic formData) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response rest = await dio.post(url, data: formData, options: Options(followRedirects: false, validateStatus: (status) => true,));
      debugPrint("$url response:${rest.data ?? ""}");
      dio.close();
      return rest.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiNotBody(String url) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response rest = await dio.post(url);
      debugPrint("$url response:${rest.data ?? ""}");
      dio.close();
      return rest.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiWithContentType(String url, dynamic formData) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
          contentType: 'application/x-www-form-urlencoded',
        ),
      )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response rest = await dio.post(url, data: formData);
      debugPrint("$url response:${rest.data ?? ""}");
      dio.close();
      return rest.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiWithHeaders(
      String url, body, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.post(url, data: body, options: Options(headers: header));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiWithHeadersWithoutData(
      String url, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.post(url, options: Options(headers: header, followRedirects: false));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiWithHeadersAndContentType(
      String url, dynamic body,
      {String? contentType, Map<String, dynamic>? header}) async {
    try {
      var dio = Dio(
        BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(milliseconds: 500000),
            receiveTimeout: const Duration(milliseconds: 300000),
            responseType: ResponseType.json,
            maxRedirects: 0,
            headers: header,
            contentType: 'application/x-www-form-urlencoded'),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue = await dio.post(url,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header?.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> postApiWithHeadersContentType(
      String url, dynamic body, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
          contentType: 'application/x-www-form-urlencoded',
          headers: header,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.post(url, data: body, options: Options(headers: header));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> getApi(String url, {String? baseurl}) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseurl ?? baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restGet = await dio.get(url);
      debugPrint("$url response:${restGet.data ?? ""}");
      dio.close();
      return restGet.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> getApiWithHeaders(
      String url, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 1,
        ),
      )..interceptors.addAll([
        AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restGet = await dio.get(url, options: Options(headers: header));
      debugPrint("$url response:${restGet.data ?? ""}");
      dio.close();
      header.clear();
      return restGet.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> putApiWithHeaders(
      String url, dynamic body, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.put(url, data: body, options: Options(headers: header));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> putApiWithHeadersAndContentType(
      String url, dynamic body, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(milliseconds: 500000),
            receiveTimeout: const Duration(milliseconds: 300000),
            responseType: ResponseType.json,
            maxRedirects: 0,
            contentType: 'application/x-www-form-urlencoded'),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue = await dio.put(url,
          data: body,
          options: Options(
              headers: header, contentType: Headers.formUrlEncodedContentType));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> putApi(String url, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.put(url, options: Options(headers: header));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  static Future<dynamic> deleteApi(String url, Map<String, dynamic> header) async {
    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 500000),
          receiveTimeout: const Duration(milliseconds: 300000),
          responseType: ResponseType.json,
          maxRedirects: 0,
        ),
      )..interceptors.addAll([
        // AuthorizationInterceptor(),
        LoggerInterceptor(),
      ]);
      Response restValue =
      await dio.delete(url, options: Options(headers: header));
      debugPrint("$url response:${restValue.data ?? ""}");
      dio.close();
      header.clear();
      return restValue.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);

        return jsonDecode(e.response.toString());
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

}