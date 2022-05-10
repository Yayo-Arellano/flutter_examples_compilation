import 'package:basic_landing_webpage/src/my_web_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "Basic landing webpage",
        home: MyWebPage(),
      ),
    ),
  );
}
