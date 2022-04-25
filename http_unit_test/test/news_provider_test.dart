import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:http_unit_test/src/data_provider/news_provider.dart';

void main() {
  test('Top headlines response is correct', () async {
    final provider = _getProvider('test/top_headlines.json');
    final articles = await provider.topHeadlines('us');

    expect(articles.length, 2);
    expect(articles[0].author, 'Sophie Lewis');
    expect(articles[1].author, 'KOCO Staff');
  });

  test('Api key missing exception is thrown correctly', () async {
    final provider = _getProvider('test/api_key_missing.json');
    expect(provider.topHeadlines('mx'), throwsA(predicate((exception) => exception is MissingApiKeyException)));
  });

  test('Invalid Api key exception is thrown correctly', () async {
    final provider = _getProvider('test/api_key_invalid.json');
    expect(provider.topHeadlines('mx'), throwsA(predicate((exception) => exception is ApiKeyInvalidException)));
  });
}

final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};

NewsProvider _getProvider(String filePath) => NewsProvider(httpClient: _getMockProvider(filePath));

MockClient _getMockProvider(String filePath) =>
    MockClient((_) async => Response(await File(filePath).readAsString(), 200, headers: headers));
