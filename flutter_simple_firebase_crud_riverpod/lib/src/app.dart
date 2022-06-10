import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/cubit/auth_cubit.dart';
import 'package:flutter_simple_firebase_crud_riverpod/src/navigation/routes.dart';
import 'package:riverpod/riverpod.dart';

final authProvider = StateNotifierProvider<AuthCubit, AuthState>((ref) {
  return AuthCubit()..init();
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
