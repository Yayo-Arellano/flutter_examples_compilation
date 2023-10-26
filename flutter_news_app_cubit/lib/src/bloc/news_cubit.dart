import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_cubit/src/data_source/news_data_source.dart';
import 'package:flutter_news_app_cubit/src/dependency_injection.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/repository/news_repository.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository = getIt();
  String? _currentSearch;
  Locale _currentLocale;

  NewsCubit(Locale locale)
      : _currentLocale = locale,
        super(NewsLoadingState());

  Future<void> searchNews({
    String? search,
  }) async {
    _currentSearch = search;
    return _search();
  }

  Future<void> clearSearch() async {
    _currentSearch = null;
    return _search();
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    return _search();
  }

  Future<void> _search() async {
    try {
      emit(NewsLoadingState());

      final news = await switch (_currentSearch) {
        null => _repository.fetchTopHeadlines(
            locale: _currentLocale,
          ),
        _ => _repository.fetchEverything(
            locale: _currentLocale,
            search: _currentSearch,
          )
      };

      emit(NewsSuccessState(news));
    } on Exception catch (e) {
      if (e is MissingApiKeyException) {
        emit(NewsErrorState('Please check the API key'));
      } else if (e is ApiKeyInvalidException) {
        emit(NewsErrorState('The api key is not valid'));
      } else {
        emit(NewsErrorState('Unknown error'));
      }
    }
  }
}

sealed class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<Article> news;

  NewsSuccessState(this.news);

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
