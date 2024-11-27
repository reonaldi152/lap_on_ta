import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class BannerViewmodel {
  Future<Resp> banner() async {
    // String? token = await Session().getUserToken();
    //
    // var header = <String, dynamic>{};
    // header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApi(Endpoint.bannerUrl);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> detailVenue({bannerid}) async {

    var resp = await Network.getApi("${Endpoint.bannerUrl}/$bannerid");
    Resp data = Resp.fromJson(resp);
    return data;
  }
}