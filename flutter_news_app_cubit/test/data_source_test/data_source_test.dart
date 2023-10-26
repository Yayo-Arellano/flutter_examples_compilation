import 'dart:io';

import 'package:flutter_news_app_cubit/src/data_source/news_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

final headers = {HttpHeaders.contentTypeHeader: ContentType.json.toString()};
const mockPath = 'test/data_source_test';

void main() {
  late MockClient mockClient;
  late NewsDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockClient = MockClient();
    dataSource = NewsDataSource(httpClient: mockClient);
  });

  group('When calling fetchEverything', () {
    test('The response contains two news', () async {
      final response = await getMockBody('$mockPath/success_response.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200, headers: headers);
      });

      final articles = await dataSource.fetchEverything(language: 'es');

      expect(articles.length, 2);
      expect(articles[0].author, 'Sophie Lewis');
      expect(articles[1].author, 'KOCO Staff');
    });

    test('The request contains the expected params', () async {
      final response = await getMockBody('$mockPath/success_response.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200, headers: headers);
      });

      const language = 'es';
      const searchTerm = 'Hello world';

      await dataSource.fetchEverything(
        language: language,
        search: searchTerm,
      );

      final uri = Uri.https(
        NewsDataSource.baseUrl,
        NewsDataSource.everything,
        {
          'apiKey': NewsDataSource.apiKey,
          'language': language,
          'q': searchTerm,
        },
      );
      verify(() => mockClient.get(uri)).called(1);
    });

    test('Correctly throws Missing API Key Exception for non-successful response', () async {
      final response = await getMockBody('$mockPath/api_key_missing.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200);
      });

      expect(
          dataSource.fetchEverything(language: 'es'),
          throwsA(
              predicate((exception) => exception is MissingApiKeyException)));
    });

    test('Correctly throws Invalid API Key Exception for non-successful response', () async {
      final response = await getMockBody('$mockPath/api_key_invalid.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200);
      });

      expect(
          dataSource.fetchEverything(language: 'es'),
          throwsA(
              predicate((exception) => exception is ApiKeyInvalidException)));
    });
  });

  group('When calling fetchTopHeadlines', () {
    test('The response contains two news', () async {
      final response = await getMockBody('$mockPath/success_response.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200, headers: headers);
      });

      final articles = await dataSource.fetchTopHeadlines(country: 'mx');

      expect(articles.length, 2);
      expect(articles[0].author, 'Sophie Lewis');
      expect(articles[1].author, 'KOCO Staff');
    });

    test('The request contains the expected params', () async {
      final response = await getMockBody('$mockPath/success_response.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200, headers: headers);
      });

      await dataSource.fetchTopHeadlines(country: 'mx');

      final uri = Uri.https(
        NewsDataSource.baseUrl,
        NewsDataSource.topHeadlines,
        {
          'apiKey': NewsDataSource.apiKey,
          'country': 'mx',
        },
      );
      verify(() => mockClient.get(uri)).called(1);
    });

    test('Correctly throws Missing API Key Exception for non-successful response', () async {
      final response = await getMockBody('$mockPath/api_key_missing.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200);
      });

      expect(
          dataSource.fetchTopHeadlines(country: 'mx'),
          throwsA(
              predicate((exception) => exception is MissingApiKeyException)));
    });

    test('Correctly throws Invalid API Key Exception for non-successful response', () async {
      final response = await getMockBody('$mockPath/api_key_invalid.json');
      when(() => mockClient.get(any())).thenAnswer((_) async {
        return Response(response, 200);
      });

      expect(
          dataSource.fetchTopHeadlines(country: 'es'),
          throwsA(
              predicate((exception) => exception is ApiKeyInvalidException)));
    });
  });
}

Future<String> getMockBody(String filePath) => File(filePath).readAsString();
