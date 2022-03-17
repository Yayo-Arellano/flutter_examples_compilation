import 'dart:io';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_architecture/src/data_source/news_source.dart';

void main() {
  test('Top headlines response is correct', () async {
    final newsSource =
        _getDataSource('test/data_source_test/top_headlines.json');
    final articles = await newsSource.topHeadlines('us');

    expect(articles.length, 2);
    expect(articles[0].author, 'Sophie Lewis');
    expect(articles[1].author, 'KOCO Staff');
  });

  test('Api key missing exception is thrown correctly', () async {
    final newsSource = _getDataSource('test/data_source_test/api_key_missing.json');
    expect(newsSource.topHeadlines('mx'), throwsA(predicate((exception) => exception is MissingApiKeyException)));
  });

  test('Invalid Api key exception is thrown correctly', () async {
    final newsSource = _getDataSource('test/data_source_test/api_key_invalid.json');
    expect(newsSource.topHeadlines('mx'), throwsA(predicate((exception) => exception is ApiKeyInvalidException)));
  });
}

final headers = {
  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
};

NewsSource _getDataSource(String filePath) =>
    NewsSource(httpClient: _getMockProvider(filePath));

MockClient _getMockProvider(String filePath) => MockClient((_) async =>
    Response(await File(filePath).readAsString(), 200, headers: headers));
