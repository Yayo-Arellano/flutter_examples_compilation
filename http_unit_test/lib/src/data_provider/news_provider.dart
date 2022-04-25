import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_unit_test/src/data_provider/response/api_response.dart';
import 'package:http_unit_test/src/model/article.dart';

class MissingApiKeyException implements Exception {}

class ApiKeyInvalidException implements Exception {}

class NewsProvider {
  static const String _apiKey = 'fe050c83e88a4c9d93e6bff7842a1da1';

  static const String _baseUrl = 'newsapi.org';
  static const String _topHeadlines = '/v2/top-headlines';

  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  Future<List<Article>> topHeadlines(String country) async {
    final result = await _callGetApi(
      endpoint: _topHeadlines,
      params: {
        'country': country,
        'apiKey': _apiKey,
      },
    );
    return result.articles!;
  }

  Future<ApiResponse> _callGetApi({
    required String endpoint,
    required Map<String, String> params,
  }) async {
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    print(response.body);
    final result = ApiResponse.fromJson((json.decode(response.body)));


    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }
    return result;
  }
}
