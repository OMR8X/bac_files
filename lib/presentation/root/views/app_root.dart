import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/presentation/root/state/theme/app_theme_bloc.dart';
import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../downloads/state/downloads/downloads_bloc.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AppThemeBloc>()..add(const InitializeAppThemeEvent()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) =>  sl<UploadsBloc>()..add(const InitializeUploadsEvent()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) =>  sl<DownloadsBloc>()..add(const InitializeDownloadsEvent()),
          child: Container(),
        ),
      ],
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
