import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final bool isConnected;
  Future<bool> checkCurrentStatus() async {
    ///
    final connectivityResult = await (Connectivity().checkConnectivity());

    ///
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.other)) {
      return false;
    }

    return false;
  }

  NetworkInfo(this.isConnected);
}
