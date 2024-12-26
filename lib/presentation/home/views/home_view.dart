import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/sizes_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/core/services/share_files_service.dart';
import 'package:bac_files_admin/core/widgets/dialogs/delete_item_dialog.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/text_button_widget.dart';
import 'package:bac_files_admin/features/auth/domain/entites/user_data.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/presentation/auth/state/bloc/auth_bloc.dart';
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
    sl<HomeBloc>().add(const HomeLoadFilesEvent());
    ShareFilesService.initialize();
    super.initState();
  }

  unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الرئيسية"),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              context.push(AppRoutes.settings.path);
            },
            icon: const Icon(
              Icons.settings_outlined,
              size: 20,
            ),
          ),
        ),
        body: BlocProvider.value(
          value: sl<HomeBloc>(),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  SearchBarWidget(
                    key: const ValueKey("search_bar"),
                    onChanged: (keywords) {
                      sl<HomeBloc>().add(HomeLoadFilesEvent(keywords: keywords));
                    },
                    onFieldSubmitted: (p0) {},
                    selectedItems: state.categories,
                    onFiltersSubmitted: (List<String> categories) {
                      sl<HomeBloc>().add(HomeLoadFilesEvent(categories: categories));
                    },
                  ),
                  Expanded(
                    child: BacFilesListBuilderWidget(
                      isFetching: state.status == HomeStatus.fetchingMoreData,
                      isLoading: state.status == HomeStatus.loading,
                      files: state.files,
                      onRefresh: () {
                        sl<HomeBloc>().add(const HomeLoadFilesEvent());
                      },
                      onEndReached: () {
                        sl<HomeBloc>().add(const HomeLoadMoreFilesEvent());
                      },
                      onEdit: (file) {
                        //
                        unfocus();
                        //
                        context.push(AppRoutes.updateFile.path, extra: file.id);
                      },
                      onExplore: (file) {
                        //
                        unfocus();
                        //
                        context.push(AppRoutes.exploreFile.path, extra: file.id);
                      },
                      onDelete: (file) async {
                        //
                        unfocus();
                        //
                        showDeleteItemDialog(
                          context: context,
                          onConform: () async {
                            context.read<HomeBloc>().add(DeleteFileEvent(fileId: file.id));
                          },
                          item: file.title,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
