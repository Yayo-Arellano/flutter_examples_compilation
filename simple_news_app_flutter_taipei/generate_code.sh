#!/bin/bash
set -e

fvm global 2.10.3
flutter clean
flutter pub upgrade
flutter pub run build_runner watch --delete-conflicting-outputs