// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _zh = {
  "top_headlines": "最新的新聞",
  "search_news": "找新聞",
  "view_more": "看更多"
};
static const Map<String,dynamic> _en = {
  "top_headlines": "Top Headlines",
  "search_news": "Search News",
  "view_more": "View more"
};
static const Map<String,dynamic> _es = {
  "top_headlines": "Titulares Principales",
  "search_news": "Buscar Noticias",
  "view_more": "Ver mas"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"zh": _zh, "en": _en, "es": _es};
}
