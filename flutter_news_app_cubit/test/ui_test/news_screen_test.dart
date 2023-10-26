import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_cubit/src/app.dart';
import 'package:flutter_news_app_cubit/src/dependency_injection.dart';
import 'package:flutter_news_app_cubit/src/localization/supported_locales.dart';
import 'package:flutter_news_app_cubit/src/model/article.dart';
import 'package:flutter_news_app_cubit/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc_test/news_cubit_test.dart';

void main() {
  const article1 = Article(
    title: "Title1",
    author: "Yayo",
    url: 'SomeUrl1',
    content: 'Content1',
  );
  const article2 = Article(
    title: 'Title2',
    author: "Carlos",
    url: 'SomeUrl2',
    content: 'Content2',
  );

  late MockNewsRepository mockRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await getIt.reset();
    mockRepo = MockNewsRepository();
    getIt.registerLazySingleton<NewsRepository>(() => mockRepo);
    when(() => mockRepo.fetchTopHeadlines(locale: any(named: 'locale')))
        .thenAnswer(
      (_) async => [
        article1,
        article2,
      ],
    );
  });

  setUpAll(() {
    registerFallbackValue(englishUs);
  });

  group('Screen size: small', () {
    const smallWidth = 400.0;

    testWidgets('News screens load correctly', (WidgetTester tester) async {
      tester.setScreenWidth(smallWidth);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Title2'), findsOneWidget);

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Navigate to details correctly', (WidgetTester tester) async {
      tester.setScreenWidth(smallWidth);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Title1'));
      await tester.pumpAndSettle();

      expect(find.text('Title2'), findsNothing);

      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Content1'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Screen size: medium', () {
    const mediumWidth = 800.0;
    testWidgets('News screens load correctly', (WidgetTester tester) async {
      tester.setScreenWidth(mediumWidth);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Title2'), findsOneWidget);

      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Navigate to details correctly', (WidgetTester tester) async {
      tester.setScreenWidth(mediumWidth);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Title1'));
      await tester.pumpAndSettle();

      expect(find.text('Title2'), findsNothing);

      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Content1'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Screen size: big', () {
    const bigWidth = 1200.0;
    testWidgets('News screens load correctly and details are shown correctly',
        (WidgetTester tester) async {
      tester.setScreenWidth(bigWidth);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Title1'), findsNWidgets(2));
      expect(find.text('Title2'), findsOneWidget);

      expect(find.text('Content1'), findsOneWidget);
      expect(find.text('Content2'), findsNothing);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Navigate to details correctly', (WidgetTester tester) async {
      tester.setScreenWidth(bigWidth);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Before tapping
      expect(find.text('Title1'), findsNWidgets(2));
      expect(find.text('Title2'), findsOneWidget);

      await tester.tap(find.text('Title2'));
      await tester.pumpAndSettle();

      // After tapping
      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Title2'), findsNWidgets(2));

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

extension on WidgetTester {
  setScreenWidth(double width) {
    view.physicalSize = Size(width, view.physicalSize.height);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);
  }
}
