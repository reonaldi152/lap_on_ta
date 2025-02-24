
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class CheckoutViewmodel {

  Future<Resp> checkout({required List<int> bookingId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';
    header[HttpHeaders.contentTypeHeader] = 'application/json'; // Ensure JSON Content-Type

    // Convert the booking ID list to JSON
    Map<String, dynamic> formData = {
      "booking_id": bookingId, // List is automatically serialized as an array
    };

    dynamic formDataEncode = jsonEncode(formData);

    debugPrint("tyest $formDataEncode");

    var resp = await Network.postApiWithHeaders(
      Endpoint.checkout,
      formDataEncode, // Convert the formData map to a JSON string
      header,
    );

    Resp data = Resp.fromJson(resp);
    return data;
  }


  Future<Resp> checkoutMarketplace({required productId, required variationId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "product_id": productId,
      "variation_id": variationId,
    };

    var resp = await Network.postApiWithHeadersContentType(
        Endpoint.checkoutMarketplace, formData,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }


}