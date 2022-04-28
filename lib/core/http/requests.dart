part of 'api.dart';

class Requests {
  Future<SearchResponse> getDefaultRepository({bool ignoreCache = false}) async {
    final resp = await api
        .get('/get_default_repository' + (ignoreCache ? '?_v=${Random().nextInt(100000)}' : ''));
    return SearchResponse.fromJson(resp.json);
  }

  Future<SearchResponse> search(SearchRequest request) async {
    final resp = await api.get('/search?' + request.toString());
    return SearchResponse.fromJson(resp.json);
  }
}
