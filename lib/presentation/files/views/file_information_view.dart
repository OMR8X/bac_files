import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/assets_resources.dart';
import 'package:bac_files_admin/core/resources/styles/sizes_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_files_admin/core/services/api/api_constants.dart';
import 'package:bac_files_admin/core/services/router/app_navigator.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/presentation/files/views/pdf_file_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FileInformationView extends StatelessWidget {
  const FileInformationView({super.key, required this.file});
  final BacFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          //
          const SizedBox(height: SpacesResources.s10),

          //
          _PrimaryInfoWidget(file: file),
          //
          const Divider(
            height: SpacesResources.s20,
            endIndent: SpacesResources.s10,
            indent: SpacesResources.s10,
          ),
          //
          _SecondaryInfoWidget(file: file),
          //
          const Divider(
            height: SpacesResources.s20,
            endIndent: SpacesResources.s10,
            indent: SpacesResources.s10,
          ),
          //
          _FileCategoriesWidget(file: file),
          //
          const Divider(
            height: SpacesResources.s20,
            endIndent: SpacesResources.s10,
            indent: SpacesResources.s10,
          ),
          //
          _FileActionsWidget(
            file: file,
            onOpenFile: () {
              context.push(AppRoutes.pdfFile.path, extra: file.publicUrl());
            },
            onDownloadFile: () {},
          ),
          //
          const Divider(
            height: SpacesResources.s20,
            endIndent: SpacesResources.s10,
            indent: SpacesResources.s10,
          ),
        ],
      ),
    );
  }
}

class _PrimaryInfoWidget extends StatelessWidget {
  const _PrimaryInfoWidget({required this.file});
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  ImagesResources.appIcon,
                  width: 60,
                ),
              ),
            ),

            ///
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Text(
                    file.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  //
                  const SizedBox(height: SpacesResources.s2),
                  //
                  Text(
                    '${(int.parse(file.size) / (1024 * 1024)).toStringAsFixed(2)} MB',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  //
                  const SizedBox(height: SpacesResources.s1),
                  //
                  Text(
                    sl<FileManagers>().sectionById(id: file.sectionId)?.name ?? "",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SecondaryInfoWidget extends StatelessWidget {
  const _SecondaryInfoWidget({required this.file});
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacesResources.s10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _SecondaryInfoChipWidget(
                title: sl<FileManagers>().materialById(id: file.materialId)?.name ?? "غير محدد",
                subTitle: "المادة",
              ),
              const SizedBox(
                height: SpacesResources.s15,
                child: VerticalDivider(),
              ),
              _SecondaryInfoChipWidget(
                title: file.year ?? "غير محدد",
                subTitle: "السنة",
              ),
              const SizedBox(
                height: SpacesResources.s15,
                child: VerticalDivider(),
              ),
              _SecondaryInfoChipWidget(
                title: sl<FileManagers>().teacherById(id: file.teacherId)?.name ?? "غير محدد",
                subTitle: "المعلم",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SecondaryInfoChipWidget extends StatelessWidget {
  const _SecondaryInfoChipWidget({required this.title, required this.subTitle});
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          const SizedBox(height: SpacesResources.s2),
          //
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          //
          const SizedBox(height: SpacesResources.s4),
          //
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _FileCategoriesWidget extends StatelessWidget {
  const _FileCategoriesWidget({required this.file});
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacesResources.s10),
      child: Wrap(
        children: List.generate(file.categoriesIds.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacesResources.s2,
            ),
            child: Chip(
              label: Text(sl<FileManagers>().categoryById(id: file.categoriesIds[index], nullable: true)?.name ?? ""),
              labelStyle: Theme.of(context).textTheme.labelLarge,
            ),
          );
        }),
      ),
    );
  }
}

class _FileActionsWidget extends StatelessWidget {
  const _FileActionsWidget({required this.file, required this.onOpenFile, required this.onDownloadFile});
  final BacFile file;
  final VoidCallback onOpenFile;
  final VoidCallback onDownloadFile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacesResources.s10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onOpenFile,
                  child: Text(
                    "عرض الملف",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              //
              const SizedBox(width: SpacesResources.s4),
              //
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()?.surfaceContainer,
                  ),
                  onPressed: onDownloadFile,
                  child: Text(
                    "تحميل الملف",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
