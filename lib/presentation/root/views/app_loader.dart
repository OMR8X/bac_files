import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/select_managers_usecase.dart';
import 'package:bac_files_admin/presentation/root/state/loader/app_loader_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';

class AppLoaderView extends StatefulWidget {
  const AppLoaderView({super.key});

  @override
  State<AppLoaderView> createState() => _AppLoaderViewState();
}

class _AppLoaderViewState extends State<AppLoaderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AppLoaderBloc>()..add(const AppLoaderLoadData()),
        child: BlocConsumer<AppLoaderBloc, AppLoaderState>(
          listener: (context, state) {
            if (state.state == LoadState.succeed) {
              context.pushReplacement(AppRoutes.home.path);
            }
          },
          builder: (context, state) {
            if (state.state == LoadState.failure) {
              return Center(
                child: Text(state.failure!.message),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ),
      ),
    );
  }
}
