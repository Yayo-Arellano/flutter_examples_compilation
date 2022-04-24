import 'package:flutter/cupertino.dart';

const english = Locale('en');
const spanish = Locale('es');
const chineseTraditional = Locale('zh', 'TW');
const chineseSimplified = Locale('zh', 'CN');

final supportedLocales = <Locale, String>{
  english: 'English',
  spanish: 'Español',
  chineseTraditional: '中文繁體',
  chineseSimplified: '中文簡體',
};
