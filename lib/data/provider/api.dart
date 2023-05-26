import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:petmily/data/provider/api_endpoint.dart';
import 'package:petmily/data/provider/api_exception.dart';

enum ApiType { history, login, me, petmily, register, ws }

class MyApiClient {
  final http.Client httpClient;
  MyApiClient({required this.httpClient});

  late ApiType type;

  String get path {
    switch (type) {
      case ApiType.history:
        return "/history";
      case ApiType.login:
        return "/auth/jwt/login";
      case ApiType.me:
        return "/users/me";
      case ApiType.petmily:
        return "/petmily";
      case ApiType.register:
        return "/auth/register";
      case ApiType.ws:
        return "/ws/command";
    }
  }

  String get url => APIEndpoint.apiUrl + path;

  Future<String> get(ApiType type, {required String token}) async {
    try {
      this.type = type;
      final response = await httpClient.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
      );
      return _returnResponse(response);
    } on TimeOutException catch (_) {
      throw TimeOutException('TimeOut');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<String> post(ApiType type, {dynamic header, required dynamic body, String token = ""}) async {
    try {
      this.type = type;
      final response = await httpClient.post(
        Uri.parse(url),
        headers: token.isEmpty
            ? header ?? {"Content-Type": "application/json"}
            : {"Content-Type": "application/json", "Authorization": "Bearer $token"},
        body: body,
      );
      return _returnResponse(response);
    } on TimeOutException catch (_) {
      throw TimeOutException('TimeOut');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return utf8.decode(response.bodyBytes);
      case 201:
        return utf8.decode(response.bodyBytes);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        throw BadRequestException('Not found');
      case 422:
        throw UnprocessableEntityException(response.body.toString());
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
