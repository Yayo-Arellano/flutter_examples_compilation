import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  T args<T>() => ModalRoute.of(this)?.settings.arguments as T;
}
