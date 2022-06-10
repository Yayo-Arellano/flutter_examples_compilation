// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:best_architecture_challenge/src/bloc/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:best_architecture_challenge/main.dart';

import 'bloc_test/post_cubit_test.dart';

void main() {

  testWidgets('Post screen shows 2 elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<PostCubit>(
        create: (context) => PostCubit(MockRepoImp()),
        child: MaterialApp(
          home: PostPage(title: 'FlutterTaipei :) Test'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(Key('1')), findsOneWidget);
    expect(find.byKey(Key('2')), findsOneWidget);
  });
}
