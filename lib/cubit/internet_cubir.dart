import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyConnectionState {
  final bool connected;
  MyConnectionState(this.connected);
}

class ConnectionCubit extends Cubit<MyConnectionState> {
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectionCubit() : super(MyConnectionState(false)) {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.any((result) => result != ConnectivityResult.none);
      emit(MyConnectionState(connected));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
