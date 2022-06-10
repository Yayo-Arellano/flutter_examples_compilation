import 'dart:io';

import 'package:best_architecture_challenge/src/provider/rest_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Response is correct ', () async {
    final provider = _getProvider('test/provider_test/mock_response.json');
    final articles = await provider.getPostList();

    expect(articles.length, 2);
    expect(articles[0].id, 1);
    expect(articles[1].id, 2);
  });

  test('Exception will be thrown', () async {
    final provider = _getProvider('test/provider_test/mock_response_error.json');
    expect(provider.getPostList(), throwsA(predicate((exception) => exception is TypeError)));
  });
}

final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};

/// Provider with the mocked response file
RestProvider _getProvider(String filePath) => RestProvider(httpClient: _getMockProvider(filePath));

MockClient _getMockProvider(String filePath) =>
    MockClient((_) async => Response(await File(filePath).readAsString(), 200, headers: headers));
