import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class VenueViewmodel {
  Future<Resp> venue() async {
    // String? token = await Session().getUserToken();
    //
    // var header = <String, dynamic>{};
    // header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApi(Endpoint.venueUrl);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> detailVenue({venueid}) async {

    var resp = await Network.getApi("${Endpoint.venueUrl}/$venueid");
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> category() async {
    // String? token = await Session().getUserToken();
    //
    // var header = <String, dynamic>{};
    // header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApi(Endpoint.categoryUrl);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> venueByCategory({categoryId}) async {

    var resp = await Network.getApi("${Endpoint.venueCategoryUrl}/$categoryId");
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> scheduleVenue({venueID, date}) async {

    var resp = await Network.getApi("${Endpoint.venueUrl}/$venueID/schedules?date=$date");
    Resp data = Resp.fromJson(resp);
    return data;
  }
}