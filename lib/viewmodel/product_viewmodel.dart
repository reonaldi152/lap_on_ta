import 'dart:io';
import 'package:flutter/material.dart';

import '../config/endpoint.dart';
import '../config/model/resp.dart';
import '../config/network.dart';
import '../config/pref.dart';

class ProductViewmodel {
  Future<Resp> product() async {
    var resp = await Network.getApi(Endpoint.product);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> detailProduct({productId}) async {

    var resp = await Network.getApi("${Endpoint.product}/$productId");
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> categoryMarketplace() async {

    var resp = await Network.getApi(Endpoint.categoryMarketplace);
    Resp data = Resp.fromJson(resp);
    return data;
  }

  Future<Resp> productByCategory({categoryMarketplaceId}) async {

    var resp = await Network.getApi("${Endpoint.productByCategory}/$categoryMarketplaceId");
    Resp data = Resp.fromJson(resp);
    return data;
  }
}