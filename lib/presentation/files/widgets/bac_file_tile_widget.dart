import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/border_radius_resources.dart';
import '../../../core/resources/styles/decoration_resources.dart';
import '../../../core/resources/styles/font_styles_manager.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/sizes_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';

class BacFileTileWidget extends StatelessWidget {
  const BacFileTileWidget({
    super.key,
    this.onExplore,
    this.onEdit,
    this.onDelete,
    required this.file,
  });
  final BacFile file;
  final void Function(BacFile file)? onExplore;
  final void Function(BacFile file)? onEdit;
  final void Function(BacFile file)? onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: PaddingResources.padding_0_2,
          width: SizesResources.mainWidth(context),
          decoration: DecorationResources.tileDecoration(theme: Theme.of(context)),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadiusResource.tileBorderRadius,
            child: InkWell(
              onTap: () {
                if (onExplore == null) return;
                onExplore!(file);
              },
              borderRadius: BorderRadiusResource.tileBorderRadius,
              child: Padding(
                padding: PaddingResources.padding_4_2,
                child: Row(
                  children: [
                    //
                    const _FileExtensionIconWidget(extension: 'PDF'),
                    //
                    const SizedBox(width: SpacesResources.s4),
                    //
                    _DetailsWidget(file: file),
                    //
                    _EditIconWidget(onPressed: () {
                      if (onEdit == null) return;
                      onEdit!(file);
                    }),
                    //
                    _DeleteIconWidget(onPressed: () {
                      if (onDelete == null) return;
                      onDelete!(file);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({
    super.key,
    required this.file,
  });
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            file.title,
            style: TextStyle(
              fontWeight: FontWeightResources.bold,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: FontSizeResources.s12,
            ),
          ),
          const SizedBox(height: SpacesResources.s1),
          Text(
            sl<FileManagers>().materialById(id: file.materialId)!.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: FontSizeResources.s10,
            ),
          )
        ],
      ),
    );
  }
}

class _FileExtensionIconWidget extends StatelessWidget {
  const _FileExtensionIconWidget({
    super.key,
    required this.extension,
  });
  final String extension;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: PaddingResources.padding_1_1,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusResource.tileBorderRadius,
        color: Theme.of(context).colorScheme.primary,
      ),
      width: 35,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.only(top: SpacesResources.s1),
        child: Text(
          extension,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeightResources.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _EditIconWidget extends StatelessWidget {
  const _EditIconWidget({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.edit,
        size: 15,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _DeleteIconWidget extends StatelessWidget {
  const _DeleteIconWidget({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onError,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.delete,
        size: 15,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
