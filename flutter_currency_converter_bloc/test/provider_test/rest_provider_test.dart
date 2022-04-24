import 'dart:io';

import 'package:flutter_currency_converter/src/provider/rest_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Latest currency api will return correctly', () async {
    final provider = _getProvider('test/provider_test/latest.json');
    final result = await provider.latest();
    final currency = result.item1;
    final timestamp = result.item2;

    expect(currency.length, 2);
    expect(currency['AED'], 4.338252);
    expect(currency['AFN'], 91.224956);
    expect(timestamp, 1616680095);
  });

  test('Access key invalid exception is thrown correctly', () async {
    final provider = _getProvider('test/provider_test/access_key_invalid.json');

    expect(provider.latest(), throwsA(predicate((exception) => exception is InvalidApiKeyException)));
  });
}

final headers = {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'};

RestProvider _getProvider(String filePath) => RestProvider(httpClient: _getMockProvider(filePath));

MockClient _getMockProvider(String filePath) =>
    MockClient((_) async => Response(await File(filePath).readAsString(), 200, headers: headers));
