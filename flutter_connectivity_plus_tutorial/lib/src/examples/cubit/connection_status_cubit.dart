import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_connectivity_tutorial/src/main.dart';
import 'package:flutter_connectivity_tutorial/src/utils/check_internet_connection.dart';

class ConnectionStatusCubit extends Cubit<ConnectionStatus> {
  late StreamSubscription _connectionSubscription;

  ConnectionStatusCubit() : super(ConnectionStatus.online) {
    _connectionSubscription = internetChecker.internetStatus().listen(emit);
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
