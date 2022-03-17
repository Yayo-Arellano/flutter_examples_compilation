import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/main.dart';
import 'package:flutter_bloc_architecture/src/dependency_injection/dependency_injection.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    getIt.registerLazySingleton<NewsRepository>(() => MyOwnMockRepository());
  });

  testWidgets('News screens load correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TopNews(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Tutorial 1'), findsOneWidget);
    expect(find.text('Tutorial 2'), findsOneWidget);
  });
}

class MyOwnMockRepository extends NewsRepository {
  final article1 =
      Article(title: "Tutorial 1", author: "Yayo", url: 'https://');
  final article2 =
      Article(title: "Tutorial 2", author: "Carlos", url: 'https://');

  @override
  Future<List<Article>> topHeadlines(String country) async {
    return [article1, article2];
  }
}
