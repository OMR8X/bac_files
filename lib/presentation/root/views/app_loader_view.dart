import 'package:bac_files/core/services/router/index.dart';
import 'package:bac_files/presentation/root/state/loader/app_loader_bloc.dart';
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
  void initState() {
    sl<AppLoaderBloc>().add(const AppLoaderLoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: sl<AppLoaderBloc>(),
        child: BlocBuilder<AppLoaderBloc, AppLoaderState>(
          builder: (context, state) {
            if (state.state == LoadState.succeed) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacement(AppRoutes.home.path);
              });
            }

            if (state.state == LoadState.unauthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacement(AppRoutes.authViewsManager.path);
              });
            }
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
