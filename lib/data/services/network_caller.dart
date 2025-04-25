import 'dart:convert';
import 'package:ecommerce_product_listing/data/models/network_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {};
      debugPrint(url);
      final Response response = await get(uri, headers: headers);
      _printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _printResponse(String url, Response response) {
    debugPrint(
      'Url:$url\nResponse Code:${response.statusCode}\nBody:${response.body}',
    );
  }
}
