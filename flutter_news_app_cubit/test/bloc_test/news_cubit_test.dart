import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_news_app_cubit/src/bloc/news_cubit.dart';
import 'package:flutter_news_app_cubit/src/data_source/news_data_source.dart';
import 'package:flutter_news_app_cubit/src/dependency_injection.dart';
import 'package:flutter_news_app_cubit/src/localization/supported_locales.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

const mockLocale = Locale('en', 'US');
const mockTopArticle = Article(title: "TopArticle", url: "someUrl");
const mockEverythingArticle = Article(title: "Everything", url: "someUrl");

void main() {
  late MockNewsRepository mockRepo;
  setUp(() async {
    mockRepo = MockNewsRepository();
    getIt.registerSingleton<NewsRepository>(mockRepo);

    when(() => mockRepo.fetchEverything(
          locale: mockLocale,
          search: any(named: 'search'),
        )).thenAnswer((_) async => [mockEverythingArticle]);

    when(() => mockRepo.fetchTopHeadlines(locale: mockLocale))
        .thenAnswer((_) async => [mockTopArticle]);
  });

  tearDown(() async {
    await getIt.reset();
  });

  blocTest<NewsCubit, NewsState>(
      'When the search term is null '
      'fetchTopHeadlines will be called '
      'and the state will contain the mockTopArticle',
      build: () => NewsCubit(mockLocale),
      act: (cubit) async => cubit.searchNews(),
      expect: () => [
            NewsLoadingState(),
            NewsSuccessState(const [mockTopArticle])
          ],
      verify: (cubit) {
        verify(() => mockRepo.fetchTopHeadlines(locale: mockLocale)).called(1);
      });

  blocTest<NewsCubit, NewsState>(
      'When the search term is not null '
      'fetchEverything will be called '
      'and the state will contain the mockEverythingArticle',
      build: () => NewsCubit(mockLocale),
      act: (cubit) async => cubit.searchNews(search: 'Hello world'),
      expect: () => [
            NewsLoadingState(),
            NewsSuccessState(const [mockEverythingArticle])
          ],
      verify: (cubit) {
        verify(
          () => mockRepo.fetchEverything(
            locale: mockLocale,
            search: 'Hello world',
          ),
        ).called(1);
      });

  blocTest<NewsCubit, NewsState>(
      'When the search term is not null '
      'fetchEverything will be called '
      'and then clearing the search will trigger a new search '
      'then fetchTopHeadlines will be called '
      'and states will be emitted correctly',
      build: () => NewsCubit(mockLocale),
      act: (cubit) async {
        await cubit.searchNews(search: 'Hello world');
        await cubit.clearSearch();
      },
      expect: () => [
            NewsLoadingState(),
            NewsSuccessState(const [mockEverythingArticle]),
            NewsLoadingState(),
            NewsSuccessState(const [mockTopArticle])
          ],
      verify: (cubit) {
        verify(
          () => mockRepo.fetchEverything(
            locale: mockLocale,
            search: 'Hello world',
          ),
        ).called(1);
        verify(() => mockRepo.fetchTopHeadlines(locale: mockLocale)).called(1);
      });

  blocTest<NewsCubit, NewsState>(
    'When the Api key is not valid exception is handled correctly',
    build: () {
      when(() => mockRepo.fetchTopHeadlines(locale: mockLocale))
          .thenAnswer((_) async => throw ApiKeyInvalidException());
      return NewsCubit(englishUs);
    },
    act: (cubit) async => cubit.searchNews(),
    expect: () => [
      NewsLoadingState(),
      NewsErrorState('The api key is not valid'),
    ],
  );
}
