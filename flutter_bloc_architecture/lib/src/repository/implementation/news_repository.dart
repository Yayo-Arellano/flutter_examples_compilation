import 'package:flutter_bloc_architecture/src/data_provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsRepository extends NewsRepositoryBase {
  final NewsProvider _provider;

  NewsRepository(this._provider);

  @override
  Future<List<Article>> topHeadlines(String country) => _provider.topHeadlines(country);
}
