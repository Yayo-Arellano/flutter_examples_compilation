#!/bin/bash
set -e

fvm global 3.7.0
flutter clean
flutter pub upgrade
flutter pub run build_runner watch --delete-conflicting-outputs