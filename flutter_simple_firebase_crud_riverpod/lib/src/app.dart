import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/navigation/routes.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/notifiers/auth_notifier.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier()..init();
});

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next == AuthState.signedOut) {
        _navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Routes.intro, (r) => false);
      } else if (next == AuthState.signedIn) {
        _navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
      }
    });
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Authentication Flow',
      onGenerateRoute: Routes.routes,
    );
  }
}
