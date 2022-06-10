import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/app.dart';
import 'package:flutter_bloc_architecture/src/data_provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/repository/implementation/news_repository.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';


void main() async {
  /// El provider y repository solo sera inicializado solo una vez.
  final newsProvider = NewsProvider();
  final newsRepository = NewsRepository(newsProvider);

  /// Inyectamos el repository al arbol de widgets.
  runApp(
    RepositoryProvider<NewsRepositoryBase>(
      create: (_) => newsRepository,
      child: MyApp(),
    ),
  );
}
