
import 'dart:io';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class RefundViewmodel {
  Future<Resp> refund({required bookingId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    Map<String, dynamic> formData = {
      "booking_id": bookingId,
    };

    var resp = await Network.postApiWithHeadersContentType(
        "${Endpoint.bookingUrl}/$bookingId/refund", formData,header);
    Resp data = Resp.fromJson(resp);
    return data;
  }
}