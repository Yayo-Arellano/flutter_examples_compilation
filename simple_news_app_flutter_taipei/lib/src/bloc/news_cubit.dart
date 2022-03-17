import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_architecture/src/data_source/news_source.dart';
import 'package:flutter_bloc_architecture/src/dependency_injection/dependency_injection.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository = getIt.get();

  NewsCubit() : super(NewsInitialState());

  Future<void> loadTopNews({String country = 'tw'}) async {
    try {
      emit(NewsLoadingState());
      final news = await _repository.topHeadlines(country);
      emit(NewsLoadCompleteState(news));
    } on Exception catch (e) {
      if (e is MissingApiKeyException) {
        emit(NewsErrorState('Please check the API key'));
      } else if (e is ApiKeyInvalidException) {
        emit(NewsErrorState('The API key is incorrect'));
      } else {
        emit(NewsErrorState('Unknown error'));
      }
    }
  }
}

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadCompleteState extends NewsState {
  final List<Article> news;

  NewsLoadCompleteState(this.news);

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
