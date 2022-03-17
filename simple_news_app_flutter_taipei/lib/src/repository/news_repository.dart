import 'package:flutter_bloc_architecture/src/model/article.dart';

abstract class NewsRepository {
  Future<List<Article>> topHeadlines(String country);
}