part of 'api.dart';

class Requests {
  Future<SearchResponse> getDefaultRepository({bool ignoreCache = false}) async {
    final Map<String, String> headers = ignoreCache ? {'Cache-Control': 'no-cache'} : {};
    final resp = await api.get('/get_default_repository', headers: headers);
    return SearchResponse.fromJson(resp.json);
  }

  Future<SearchResponse> search(SearchRequest request) async {
    final resp = await api.get('/search?' + request.toString());
    return SearchResponse.fromJson(resp.json);
  }

  Future<void> migrateUser(String idToken, MigrationDetails details) async {
    await api.get('/migrate_user?${details.toString()}', headers: {
      'Authorization': 'Bearer $idToken',
    });
  }
}
