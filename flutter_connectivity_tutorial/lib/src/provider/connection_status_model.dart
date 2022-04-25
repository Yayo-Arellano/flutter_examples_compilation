import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectionStatusModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectionSubscription;
  bool _isOnline = true;

  ConnectionStatusModel() {
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    _checkInternetConnection();
  }

  bool get isOnline => _isOnline;

  Future<void> _checkInternetConnection() async {
    try {
      // Sometimes the callback is called when we reconnect to wifi, but the internet is not really functional
      // This delay try to wait until we are really connected to internet
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      } else {
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
