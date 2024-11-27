import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class AuthViewmodel {
  Future<Resp> login({email, password}) async {

    Map<String, dynamic> formData = {
      "email": email,
      "password": password,
    };

    var resp = await Network.postApiWithHeadersAndContentType(Endpoint.authLoginUrl, formData);
    var data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> register({name, email, phone, password, confirmPassword}) async {

    Map<String, dynamic> formData = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    var resp = await Network.postApiWithHeadersAndContentType(Endpoint.authRegisterUrl, formData);
    var data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> logout() async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.postApiWithHeadersWithoutData(
        Endpoint.logoutUrl,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> userDetail() async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';
    debugPrint("ini header user detail $header");

    var resp = await Network.getApiWithHeaders(
        Endpoint.userDetailUrl, header);
    Resp data = Resp.fromJson(resp);
    return data;
  }


  Future<Resp> requestCode({email}) async {
    Map<String, dynamic> formData = {
      "email": email,
    };

    var resp = await Network.postApiWithHeadersAndContentType(Endpoint.requestCodePasswordUrl, formData);
    var data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> resetPassword({code, password}) async {
    Map<String, dynamic> formData = {
      "code": code,
      "password": password,
    };

    var resp = await Network.postApiWithHeadersAndContentType(Endpoint.resetPasswordUrl, formData);
    var data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> editProfile({name,phone}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "name": name,
      "phone": phone,
    };

    var resp = await Network.postApiWithHeaders(Endpoint.userDetailUrl, formData, header);
    var data = Resp.fromJson(resp);
    return data;
  }

}