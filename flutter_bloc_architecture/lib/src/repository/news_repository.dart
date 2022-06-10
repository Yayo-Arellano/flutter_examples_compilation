import 'package:flutter_bloc_architecture/src/model/article.dart';

abstract class NewsRepositoryBase {
  Future<List<Article>> topHeadlines(String country);
}
