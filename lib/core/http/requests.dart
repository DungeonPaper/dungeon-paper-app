part of 'api.dart';

class Requests {
  Future<SearchResponse> search(SearchRequest request) async {
    final resp = await api.get('/search?' + request.toString());
    return SearchResponse.fromJson(resp.json);
  }
}
