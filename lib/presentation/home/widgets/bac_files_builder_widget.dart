import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../features/files/domain/entities/bac_file.dart';
import '../../files/widgets/bac_file_tile_widget.dart';

class BacFilesListBuilderWidget extends StatefulWidget {
  const BacFilesListBuilderWidget({
    super.key,
    required this.files,
    this.onExplore,
    this.onEdit,
    this.onDelete,
    required this.isLoading,
    required this.isFetching,
    required this.onEndReached,
    required this.onRefresh,
  });

  final bool isLoading;
  final bool isFetching;
  final List<BacFile> files;
  final void Function(BacFile file)? onExplore;
  final void Function(BacFile file)? onEdit;
  final void Function(BacFile file)? onDelete;
  final VoidCallback onEndReached;
  final VoidCallback onRefresh;

  @override
  BacFilesListBuilderWidgetState createState() => BacFilesListBuilderWidgetState();
}

class BacFilesListBuilderWidgetState extends State<BacFilesListBuilderWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _hasFetchedMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200 && !_hasFetchedMore) {
      // Trigger fetch when within 200 pixels of the end of the list
      if (widget.files.length > 1) {
        widget.onEndReached();
        _hasFetchedMore = true;
      }
    } else if (_scrollController.position.extentAfter > 200) {
      // Reset flag when user scrolls up
      _hasFetchedMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return AnimationLimiter(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Durations.medium4);
            widget.onRefresh();
          },
          child: ListView.builder(
            key: const ValueKey("bac_files_list_builder_widget"),
            controller: _scrollController,
            itemCount: widget.files.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.files.length) {
                return SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isFetching) const CupertinoActivityIndicator(),
                    ],
                  ),
                );
              }
              return StaggeredListWrapperWidget(
                key: ValueKey(widget.files[index].title),
                position: index,
                child: BacFileTileWidget(
                  file: widget.files[index],
                  onEdit: widget.onEdit,
                  onExplore: widget.onExplore,
                  onDelete: widget.onDelete,
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
