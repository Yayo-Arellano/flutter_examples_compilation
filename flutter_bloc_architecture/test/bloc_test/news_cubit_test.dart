import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/data_provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_cubit_test.mocks.dart';

@GenerateMocks([NewsRepositoryBase])
void main() {


  group('News Test', () {
    final article = Article(title: "Tutorial", author: "Yayo");
    final mockRepo = MockNewsRepositoryBase();

    blocTest<NewsCubit, NewsState>(
      'News will be loaded correctly',
      build: () {
        when(mockRepo.topHeadlines(any)).thenAnswer((_) async => [article]);
        return NewsCubit(mockRepo);
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
        when(mockRepo.topHeadlines(any)).thenAnswer((_) async => throw ApiKeyInvalidException());
        return NewsCubit(mockRepo);
      },
      act: (cubit) async => cubit.loadTopNews(),
      expect: () => [
        NewsLoadingState(),
        NewsErrorState('La api Key no es valida'),
      ],
    );
  });
}
