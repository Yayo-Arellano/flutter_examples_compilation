import 'dart:convert';

import 'package:flutter_news_app_cubit/src/data_source/response/api_response.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:http/http.dart';

class MissingApiKeyException implements Exception {}

class ApiKeyInvalidException implements Exception {}

class NewsDataSource {
  /// Replace with your own API key
  static const String apiKey = 'fe050c83e88a4c9d93e6bff7842a1da1';

  static const String baseUrl = 'newsapi.org';
  static const String everything = '/v2/everything';
  static const String topHeadlines = '/v2/top-headlines';

  final Client _httpClient;

  NewsDataSource({Client? httpClient}) : _httpClient = httpClient ?? Client();

  Future<List<Article>> fetchTopHeadlines({
    required String country,
  }) async {
    final params = {
      'apiKey': apiKey,
      'country': country,
    };

    final result = await _callGetApi(
      endpoint: topHeadlines,
      params: params,
    );
    return result.articles!;
  }

  Future<List<Article>> fetchEverything({
    required String language,
    String? search,
  }) async {
    final params = {
      'apiKey': apiKey,
      'language': language,
    };

    if (search != null) params['q'] = search;

    final result = await _callGetApi(
      endpoint: everything,
      params: params,
    );
    return result.articles!;
  }

  Future<ApiResponse> _callGetApi({
    required String endpoint,
    required Map<String, String> params,
  }) async {
    final uri = Uri.https(baseUrl, endpoint, params);
    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }

    return result;
  }
}
