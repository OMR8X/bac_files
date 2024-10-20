import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../features/files/domain/entities/bac_file.dart';
import '../../files/widgets/bac_file_tile_widget.dart';

class BacFilesListBuilderWidget extends StatelessWidget {
  const BacFilesListBuilderWidget({
    super.key,
    required this.files,
    this.onExplore,
    this.onEdit,
    this.onDelete,
    required this.isLoading,
  });
  final bool isLoading;
  final List<BacFile> files;
  final void Function(BacFile file)? onExplore;
  final void Function(BacFile file)? onEdit;
  final void Function(BacFile file)? onDelete;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CustomScrollView(
        slivers: [
          SliverSkeletonizer(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return BacFileTileWidget(
                    file: BacFile.empty(),
                    onEdit: (file) {},
                    onDelete: (file) {},
                  );
                },
                childCount: 100,
              ),
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          return BacFileTileWidget(
            file: files[index],
            onEdit: onEdit,
            onExplore: onExplore,
            onDelete: onDelete,
          );
        },
      );
    }
  }
}
