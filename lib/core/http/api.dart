import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:flutter/material.dart';

import 'api_base.dart';
import 'api_requests/migration.dart';

part 'requests.dart';

class Api extends ApiBase {
  static const _baseUrl =
      'https://us-central1-dw-sheet.cloudfunctions.net/main/api';
  Api() : super(_baseUrl);

  final requests = Requests();
}

final api = Api();
