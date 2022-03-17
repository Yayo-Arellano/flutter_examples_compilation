import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/data_source/news_source.dart';
import 'package:flutter_bloc_architecture/src/dependency_injection/dependency_injection.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'news_cubit_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late MockNewsRepository mockRepo;
  setUp(() async {
    await getIt.reset();
    mockRepo = MockNewsRepository();
    getIt.registerLazySingleton<NewsRepository>(() => mockRepo);
  });

  final article = Article(title: "Tutorial", author: "Yayo", url: 'https://');

  blocTest<NewsCubit, NewsState>(
    'News will be loaded correctly',
    build: () {
      when(mockRepo.topHeadlines(any)).thenAnswer((_) async => [article]);

      return NewsCubit();
    },
    act: (cubit) async => cubit.loadTopNews(),
    expect: () => [
      NewsLoadingState(),
      NewsLoadCompleteState([article])
    ],
  );

  blocTest<NewsCubit, NewsState>(
    'When the Api key is not valid exception is handled correctly',
    build: () {
      when(mockRepo.topHeadlines(any))
          .thenAnswer((_) async => throw ApiKeyInvalidException());
      return NewsCubit();
    },
    act: (cubit) async => cubit.loadTopNews(),
    expect: () => [
      NewsLoadingState(),
      NewsErrorState('The API key is incorrect'),
    ],
  );
}
