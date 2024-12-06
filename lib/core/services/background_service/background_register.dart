import 'package:flutter_background_service/flutter_background_service.dart';

abstract class BackgroundRegister {
  ///
  String get channelName;

  ///
  void register(ServiceInstance service);

  ///
  Map<String, dynamic> request({required dynamic arguments});

  ///
  void response(Map<String, dynamic>? data);
}
