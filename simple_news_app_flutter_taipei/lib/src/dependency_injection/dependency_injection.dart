import 'package:flutter_bloc_architecture/src/data_source/news_source.dart';
import 'package:flutter_bloc_architecture/src/repository/implementation/news_repository.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies() async {

  // Data sources
  getIt.registerLazySingleton<NewsSource>(() => NewsSource());

  // Repositories
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImp());
}
