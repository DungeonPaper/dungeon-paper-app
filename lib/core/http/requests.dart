part of 'api.dart';

class Requests {
  Future<SearchResponse> getDefaultRepository({bool ignoreCache = false}) async {
    var url = '/get_default_repository' + (ignoreCache ? '?__${Random().nextInt(1000000000)}' : '');
    final resp = await api.get(url);
    return SearchResponse.fromJson(resp.json);
  }

  Future<SearchResponse> search(SearchRequest request) async {
    final resp = await api.get('/search?' + request.toString());
    return SearchResponse.fromJson(resp.json);
  }
}
