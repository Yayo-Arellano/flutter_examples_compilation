import 'dart:convert';

import 'package:flutter_bloc_architecture/src/data_provider/response/api_response.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:http/http.dart' as http;

/// Esta excepción sera lanzada cuando la REST API regrese el error.code: 'apiKeyMissing'
class MissingApiKeyException implements Exception {}

/// Esta excepción sera lanzada cuando la REST API regrese el error.code: 'apiKeyInvalid'
class ApiKeyInvalidException implements Exception {}

class NewsProvider {
  /// Reemplaza esta API key por tu propia llave
  static const String _apiKey = 'fe050c83e88a4c9d93e6bff7842a1da1';

  /// Este es la URL de la REST API. Mas informacion en: https://newsapi.org/docs/endpoints/top-headlines
  static const String _baseUrl = 'newsapi.org';
  static const String _topHeadlines = '/v2/top-headlines';

  /// Dado que mas adelante vamos a crear un Mock de este objeto es necesario
  /// iniciarlizarlo por medio del constructor
  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  /// Esta funcion sera llamada desde el Repositorio
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

    print(response.body);

    /// Si la REST API contiene error lanzamos una excepción que sera manejada en la capa de presentación
    if (result.status == 'error') {
      if (result.code == 'apiKeyMissing') throw MissingApiKeyException();
      if (result.code == 'apiKeyInvalid') throw ApiKeyInvalidException();
      throw Exception();
    }

    /// Si no hay ningun error, regresamos el resultado de la REST API
    return result;
  }
}
