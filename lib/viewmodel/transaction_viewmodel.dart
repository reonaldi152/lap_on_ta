
import 'dart:io';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class TransactionViewmodel {

  Future<Resp> transactionVenue({status}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApiWithHeaders(
        "${Endpoint.historyTransactionVenue}?status=$status", header);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> transactionMarketplace() async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApiWithHeaders(
        Endpoint.historyTransactionMarketplace, header);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> detailTransactionMarketplace({transactionId}) async {
    String? token = await Session().getUserToken();

    var header = <String, dynamic>{};
    header[HttpHeaders.authorizationHeader] = 'Bearer $token';

    var resp = await Network.getApiWithHeaders(
        "${Endpoint.historyTransactionMarketplace}/$transactionId", header);
    Resp data = Resp.fromJson(resp);
    return data;
  }
}