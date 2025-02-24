import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class BookingViewmodel {
  Future<Resp> booking({fieldId,venueId,categoryId, bookingDate, timeSlots, taxPercentage, totalPayment}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "field_id": fieldId,
      "venue_id": venueId,
      "category_id": categoryId,
      "booking_date": bookingDate,
      "time_slots": timeSlots,
      "tax_percentage": taxPercentage,
      "total_payment": totalPayment,
    };
    debugPrint("form $formData");

    var resp = await Network.postApiWithHeadersContentType(
        Endpoint.bookingUrl, formData,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }
}