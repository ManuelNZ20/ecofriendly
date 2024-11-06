import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectionStatus { connected, disconnected }

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) async* {
  await for (ConnectivityResult result
      in Connectivity().onConnectivityChanged) {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    // Emite el estado de conexión basado en el resultado
    if (result == ConnectivityResult.none || !hasInternet) {
      yield ConnectionStatus.disconnected;
    } else {
      yield ConnectionStatus.connected;
    }
  }
});
