import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/presentation/root/state/loader/app_loader_bloc.dart';
import 'package:bac_files_admin/presentation/root/state/theme/app_theme_bloc.dart';
import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../auth/state/bloc/auth_bloc.dart';
import '../../downloads/state/downloads/downloads_bloc.dart';

class AppRoot extends StatelessWidget {
  const AppRoot._internal();

  static const AppRoot _instance = AppRoot._internal();

  factory AppRoot() => _instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AppThemeBloc>()..add(const InitializeAppThemeEvent()),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'مدير الملفات',
            theme: state.themeData,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale("ar"),
            ],
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
