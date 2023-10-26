import 'dart:ui';

import 'package:flutter_news_app_cubit/src/data_source/news_data_source.dart';
import 'package:flutter_news_app_cubit/src/dependency_injection.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';

class NewsRepository {
  final NewsDataSource _dataSource = getIt();

  Future<List<Article>> fetchEverything({
    required Locale locale,
    String? search,
  }) =>
      _dataSource.fetchEverything(
        language: locale.languageCode,
        search: search,
      );

  Future<List<Article>> fetchTopHeadlines({
    required Locale locale,
  }) =>
      _dataSource.fetchTopHeadlines(
        country: locale.countryCode!,
      );
}
