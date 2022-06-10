import 'dart:io';

import 'package:flutter_bloc_architecture/src/data_provider/news_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  /// Primer test: Utilizamos el archivo simulado con la respuesta correcta
  test('Top headlines response is correct', () async {
    /// Creamos un 'Mock' provider que siempre va responder el contenido de top_headlines.json
    final provider = _getProvider('test/provider_test/top_headlines.json');
    final articles = await provider.topHeadlines('us');

    /// Verificamos que el numero de noticias sea 2 y los autores sean correctos
    expect(articles.length, 2);
    expect(articles[0].author, 'Sophie Lewis');
    expect(articles[1].author, 'KOCO Staff');
  });

  /// Segundo test: Utilizamos el archivo simulado con la respuesta incorrecta
  test('Api key missing exception is thrown correctly', () async {
    /// Creamos un 'Mock' provider que siempre va responder el contenido de api_key_missing.json
    final provider = _getProvider('test/provider_test/api_key_missing.json');

    /// Esta api debe lanzar una excepción. Verificamos que la excepcion sea la esperada
    expect(provider.topHeadlines('mx'), throwsA(predicate((exception) => exception is MissingApiKeyException)));
  });

  /// Tercer test: Utilizamos el archivo simulado con la respuesta incorrecta
  test('Invalid Api key exception is thrown correctly', () async {
    /// Creamos un 'Mock' provider que siempre va responder el contenido de api_key_invalid.json
    final provider = _getProvider('test/provider_test/api_key_invalid.json');

    /// Esta api debe lanzar una excepción. Verificamos que la excepcion sea la esperada
    expect(provider.topHeadlines('mx'), throwsA(predicate((exception) => exception is ApiKeyInvalidException)));
  });
}

final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};

/// Inicializa el provider con el MockClient
NewsProvider _getProvider(String filePath) => NewsProvider(httpClient: _getMockProvider(filePath));

/// Creamos un MockClient que va regresar el JSON de acuerdo al archivo que le pasemos como parametro.
MockClient _getMockProvider(String filePath) =>
    MockClient((_) async => Response(await File(filePath).readAsString(), 200, headers: headers));
