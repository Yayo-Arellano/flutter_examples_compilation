import 'package:flutter_bloc_architecture/src/data_source/news_source.dart';
import 'package:flutter_bloc_architecture/src/dependency_injection/dependency_injection.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsRepositoryImp extends NewsRepository {
  final NewsSource newsSource = getIt.get();

  @override
  Future<List<Article>> topHeadlines(String country) async {
    return newsSource.topHeadlines(country);
  }
}
