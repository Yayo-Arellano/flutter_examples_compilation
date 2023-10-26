#!/bin/bash
set -e

flutter clean
flutter pub get
# https://pub.dev/packages/easy_localization
flutter pub run easy_localization:generate -f keys -S resources/translations -O lib/src/localization -o locale_keys.g.dart
flutter pub run easy_localization:generate -S resources/translations -O lib/src/localization
# https://flutter.dev/docs/development/data-and-backend/json#generating-code-continuously
flutter pub run build_runner watch --delete-conflicting-outputs
