part of 'api.dart';

class Requests {
  String? idToken;

  Map<String, String> get authorizationHeaders {
    assert(idToken != null, 'idToken must be set');
    return {'Authorization': 'Bearer $idToken'};
  }

  Future<SearchResponse> getDefaultRepository({bool ignoreCache = false}) async {
    final Map<String, String> headers = ignoreCache ? {'Cache-Control': 'no-cache'} : {};
    final resp = await api.get('/library/default', headers: headers);
    return SearchResponse.fromJson(resp.json);
  }

  Future<void> migrateUser(MigrationDetails details) =>
      api.get('/user/migrate?${details.toString()}', headers: authorizationHeaders);

  Future<void> sendFeedback({
    required String email,
    required String subject,
    required String body,
  }) async {
    final resp = await api.post(
      '/feedback',
      body: {
        'email': email,
        'subject': subject,
        'body': body,
      },
    );
    debugPrint('sendFeedback: ${resp.body}');
  }
}
