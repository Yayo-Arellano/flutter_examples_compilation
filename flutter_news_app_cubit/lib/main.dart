import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/app.dart';
import 'package:flutter_news_app_cubit/src/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inject the data sources and repositories
  injectDependencies();

  runApp(const MyApp());
}
