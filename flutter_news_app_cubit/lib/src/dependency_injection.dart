import 'package:flutter_news_app_cubit/src/data_source/news_data_source.dart';
import 'package:flutter_news_app_cubit/src/repository/news_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies() async {
  getIt.registerLazySingleton(() => NewsDataSource());
  getIt.registerLazySingleton(() => NewsRepository());
}
