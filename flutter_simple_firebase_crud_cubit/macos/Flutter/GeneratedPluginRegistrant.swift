//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import cloud_firestore
import desktop_webview_auth
import firebase_auth
import firebase_core
import firebase_database
import firebase_storage
import path_provider_macos
import sign_in_with_apple
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  DesktopWebviewAuthPlugin.register(with: registry.registrar(forPlugin: "DesktopWebviewAuthPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseDatabasePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseDatabasePlugin"))
  FLTFirebaseStoragePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseStoragePlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SignInWithApplePlugin.register(with: registry.registrar(forPlugin: "SignInWithApplePlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
