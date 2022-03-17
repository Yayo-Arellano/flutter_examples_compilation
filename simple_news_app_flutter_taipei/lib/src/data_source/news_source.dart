import 'dart:convert';

import 'package:flutter_bloc_architecture/src/data_source/response/api_response.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:http/http.dart' as http;

class NewsSource {
  // Please visit https://newsapi.org/ to get your own API key
  static const String _apiKey = 'xxxxxxx';

  static const String _baseUrl = 'newsapi.org';
  static const String _topHeadlines = '/v2/top-headlines';

  final http.Client _httpClient;

  NewsSource({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

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
    final result = ApiResponse.fromJson((json.decode(response.body)));
    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }
    return result;
  }
}

class MissingApiKeyException implements Exception {}

class ApiKeyInvalidException implements Exception {}
