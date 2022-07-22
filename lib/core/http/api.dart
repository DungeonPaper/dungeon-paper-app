import 'dart:convert';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_requests/migration.dart';

part 'requests.dart';

class Api {
  static const baseUrl = 'https://us-central1-dw-sheet.cloudfunctions.net/main/api';
  final requests = Requests();

  Future<Response> get(
    String url, {
    bool parse = true,
    Map<String, String>? headers,
  }) async {
    final resp = await http.get(Uri.parse(baseUrl + url), headers: headers);
    return Response.fromHttp(resp);
  }

  Future<Response> post(
    String url, {
    bool parse = true,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final resp =
        await http.post(Uri.parse(baseUrl + url), headers: headers, body: body, encoding: encoding);
    return Response.fromHttp(resp);
  }
}

class Response extends http.Response {
  Response(
    String body,
    int statusCode, {
    http.BaseRequest? request,
    Map<String, String> headers = const {},
    bool isRedirect = false,
    bool persistentConnection = true,
    String? reasonPhrase,
  }) : super(
          body,
          statusCode,
          request: request,
          headers: headers,
          isRedirect: isRedirect,
          persistentConnection: persistentConnection,
          reasonPhrase: reasonPhrase,
        );

  factory Response.fromHttp(http.Response response) => Response(
        response.body,
        response.statusCode,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );

  Map<String, dynamic> get json => jsonDecode(body);
}

final api = Api();
