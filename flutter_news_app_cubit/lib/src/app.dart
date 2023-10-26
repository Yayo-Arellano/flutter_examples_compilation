import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/localization/codegen_loader.g.dart';
import 'package:flutter_news_app_cubit/src/localization/supported_locales.dart';
import 'package:flutter_news_app_cubit/src/navigation/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      fallbackLocale: englishUs,
      useFallbackTranslations: true,
      supportedLocales: supportedLocales.keys.toList(),
      path: 'xxx',// Not needed with code generation
      assetLoader: const CodegenLoader(),
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: context.locale,
      onGenerateRoute: Routes.routes,
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
