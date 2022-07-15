import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_http_boilerplate/helpers/app_exceptions.dart';
import 'package:my_http_boilerplate/helpers/toast_manager.dart';

class BaseApiCall {
  static const timeforrequest = 5;

  Future<dynamic> getRequest(String baseUrl, String endpoint) async {
    final uri = baseUrl + endpoint;

    try {
      final response = await http
          .get(Uri.parse(uri))
          .timeout(const Duration(seconds: timeforrequest));
      final data = _processResponse(response);
      return data;
    } on TimeoutException {
      throw ApiTimeoutException(
          message: "Api Call took too long. Retry!!!", url: uri.toString());
    } on SocketException {
      throw FetchDataException(
          message: "No Internet Connection", url: uri.toString());
    }
  }

  Future<dynamic> postRequest(
      String baseUrl, String endpoint, dynamic payload) async {
    final uri = baseUrl + endpoint;

    final body = jsonEncode(payload);

    try {
      final response = await http
          .post(Uri.parse(uri), body: body)
          .timeout(const Duration(seconds: timeforrequest));
      final data = _processResponse(response);
      return data;
    } on TimeoutException {
      throw ApiTimeoutException(
          message: "Api Call took too long. Retry!!!", url: uri.toString());
    } on SocketException {
      throw FetchDataException(
          message: "No Internet Connection", url: uri.toString());
    }
  }

  _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        ToastManager.showSuccessToast("success");
        final data = jsonDecode(response.body);
        return data;

      case 201:
        ToastManager.showSuccessToast("success");

        final data = jsonDecode(response.body);
        return data;

      case 400:
        throw BadRequestException(
            message: jsonDecode(response.body),
            url: response.request!.url.toString());
      case 401:
        throw UnauthorizedException(
            message: jsonDecode(response.body),
            url: response.request!.url.toString());
      case 403:
        throw UnauthorizedException(
            message: jsonDecode(response.body),
            url: response.request!.url.toString());
      case 404:
        //404 page
        break;
      case 500:
        //500 page
        break;
      default:
        throw FetchDataException(
            message: "Error returned with the code ${response.statusCode}",
            url: response.request!.url.toString());
    }
  }
}
