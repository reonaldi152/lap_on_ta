
import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class CheckoutViewmodel {
  Future<Resp> checkout({required bookingId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "booking_id": bookingId,
    };

    var resp = await Network.postApiWithHeadersContentType(
        Endpoint.checkout, formData,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> checkoutMarketplace({required productId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "product_id": productId,
    };

    var resp = await Network.postApiWithHeadersContentType(
        Endpoint.checkoutMarketplace, formData,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }


}