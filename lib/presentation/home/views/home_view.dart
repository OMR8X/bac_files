import 'dart:async';

import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/core/services/share_files_service.dart';
import 'package:bac_files_admin/core/widgets/dialogs/delete_item_dialog.dart';
import 'package:bac_files_admin/features/files/domain/usecases/delete_file_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/presentation/home/state/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bac_files_builder_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/switch_theme_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    ShareFilesService.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الرئيسية"),
          actions: const [
            SwitchThemeWidget(),
          ],
        ),
        body: Column(
          children: [
            SearchBarWidget(
              onChanged: (keywords) {
                sl<HomeBloc>().add(HomeLoadFilesEvent(keywords: keywords));
              },
              onFieldSubmitted: (p0) {},
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => sl<HomeBloc>()..add(const HomeLoadFilesEvent()),
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return BacFilesListBuilderWidget(
                      isLoading: state.status == HomeStatus.loading,
                      files: state.files,
                      onEdit: (file) {
                        context.push(AppRoutes.updateFile.path, extra: file.id);
                      },
                      onExplore: (file) {
                        context.push(AppRoutes.exploreFile.path, extra: file.id);
                      },
                      onDelete: (file) async {
                        showDeleteItemDialog(
                          context: context,
                          onConform: () async {
                            context.read<HomeBloc>().add(DeleteFileEvent(fileId: file.id));
                          },
                          item: file.title,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
