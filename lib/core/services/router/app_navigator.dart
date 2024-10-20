import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';

extension NavigationHelpersExt on BuildContext {
  AppNavigator get navigator => AppNavigator(this);
}

class AppNavigator {
  AppNavigator(this.context);

  final BuildContext context;
}
