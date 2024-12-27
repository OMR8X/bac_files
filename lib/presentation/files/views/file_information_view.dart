import 'dart:async';

import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/resources/styles/assets_resources.dart';
import 'package:bac_files/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files/core/resources/styles/padding_resources.dart';
import 'package:bac_files/core/resources/styles/spaces_resources.dart';
import 'package:bac_files/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_files/core/services/router/index.dart';
import 'package:bac_files/features/files/domain/entities/bac_file.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:bac_files/presentation/downloads/state/downloads/downloads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/animations/staggered_item_wrapper_widget.dart';
import '../../../features/operations/domain/entities/operation.dart';
import '../../../features/operations/domain/entities/operation_state.dart';

class FileInformationView extends StatelessWidget {
  const FileInformationView({super.key, required this.file});
  final BacFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimationLimiter(
        child: ListView(
          children: [
            //
            const SizedBox(height: SpacesResources.s10),

            //
            _PrimaryInfoWidget(file: file),
            //
            const Divider(endIndent: SpacesResources.s10, indent: SpacesResources.s10),
            //
            _SecondaryInfoWidget(file: file),
            //
            const Divider(endIndent: SpacesResources.s10, indent: SpacesResources.s10),
            //
            if (file.categoriesIds.isNotEmpty) ...[
              _FileCategoriesWidget(file: file),
              //
              const Divider(endIndent: SpacesResources.s10, indent: SpacesResources.s10),
            ],
            //
            _FileActionsWidget(
              file: file,
              onOpenFile: () {
                context.push(AppRoutes.remotePdfFile.path, extra: file);
              },
              onDownloadFile: () {
                sl<DownloadsBloc>().add(AddDownloadOperationEvent(file: file));
              },
              onStopFile: (Operation operation) {
                sl<DownloadsBloc>().add(DeleteOperationEvent(operation: operation));
              },
            ),
            //
            const Divider(endIndent: SpacesResources.s10, indent: SpacesResources.s10),
          ],
        ),
      ),
    );
  }
}

class _PrimaryInfoWidget extends StatelessWidget {
  const _PrimaryInfoWidget({required this.file});
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return StaggeredItemWrapperWidget(
      position: 0,
      child: Padding(
        padding: PaddingResources.padding_0_5,
        child: Column(
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
        ),
      ),
    );
  }
}

class _SecondaryInfoWidget extends StatelessWidget {
  const _SecondaryInfoWidget({required this.file});
  final BacFile file;
  @override
  Widget build(BuildContext context) {
    return StaggeredItemWrapperWidget(
      position: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacesResources.s10,
          vertical: SpacesResources.s2,
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
                if (!(file.schoolId != null && file.teacherId == null)) ...[
                  const SizedBox(
                    height: SpacesResources.s15,
                    child: VerticalDivider(),
                  ),
                  _SecondaryInfoChipWidget(
                    title: sl<FileManagers>().teacherById(id: file.teacherId, nullable: true)?.name ?? "غير محدد",
                    subTitle: "المعلم",
                  ),
                ],
                if (file.schoolId != null) ...[
                  const SizedBox(
                    height: SpacesResources.s15,
                    child: VerticalDivider(),
                  ),
                  _SecondaryInfoChipWidget(
                    title: sl<FileManagers>().schoolById(id: file.schoolId, nullable: true)?.name ?? "غير محدد",
                    subTitle: "المدرسة",
                  ),
                ]
              ],
            ),
          ],
        ),
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
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightResources.bold,
                ),
          ),
          //
          const SizedBox(height: SpacesResources.s2),
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
    return StaggeredItemWrapperWidget(
      position: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacesResources.s10,
          vertical: SpacesResources.s2,
        ),
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
      ),
    );
  }
}

class _FileActionsWidget extends StatefulWidget {
  const _FileActionsWidget({
    required this.file,
    required this.onOpenFile,
    required this.onDownloadFile,
    required this.onStopFile,
  });
  final BacFile file;
  final VoidCallback onOpenFile;
  final VoidCallback onDownloadFile;
  final void Function(Operation operation) onStopFile;

  @override
  State<_FileActionsWidget> createState() => _FileActionsWidgetState();
}

class _FileActionsWidgetState extends State<_FileActionsWidget> {
  late double _progress = 0.0;
  late final StreamSubscription _progressSubscription;
  @override
  void initState() {
    //
    sl<DownloadsBloc>().add(const RefreshOperationEvent());
    //
    _progressSubscription = FlutterBackgroundService().on("on-progress").listen((data) {
      //
      final fileId = data!['file_id'] as String?;
      //
      if (fileId == widget.file.id) {
        setState(() => _progress = (data['sent'] as int) / (data['total'] as int));
      }
      //
    });
    super.initState();
  }

  @override
  void dispose() {
    _progressSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredItemWrapperWidget(
      position: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacesResources.s10,
          vertical: SpacesResources.s2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                BlocProvider.value(
                  value: sl<DownloadsBloc>(),
                  child: BlocBuilder<DownloadsBloc, DownloadsState>(
                    builder: (context, state) {
                      //
                      Operation? operation;
                      //
                      final operations = state.operations.where((e) => (e.file.id == widget.file.id)).toList();
                      //
                      if (operations.isNotEmpty) {
                        operation = operations.first;
                      }
                      //

                      return Expanded(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()?.surfaceContainer,
                        ),
                        onPressed: () {
                          switch (operation?.state) {
                            case null:
                              widget.onDownloadFile();
                              return;
                            case OperationState.succeed:
                              context.push(AppRoutes.localPdfFile.path, extra: operation!.path);
                              return;
                            case OperationState.created:
                              widget.onStopFile(operation!);
                            case OperationState.initializing:
                              widget.onStopFile(operation!);
                            case OperationState.pending:
                              widget.onStopFile(operation!);
                            case OperationState.uploading:
                              widget.onStopFile(operation!);
                            case OperationState.failed:
                              return;
                            case OperationState.canceled:
                              return;
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if ([null].contains(operation?.state))
                              Text(
                                "تحميل الملف",
                                style: FontStylesResources.buttonStyle.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              )
                            else if ([OperationState.succeed].contains(operation?.state))
                              Text(
                                "فتح",
                                style: FontStylesResources.buttonStyle.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              )
                            else if ([OperationState.pending].contains(operation?.state) && !(_progress > 0.0 && _progress < 100))
                              Text(
                                "قائمة الأنتظار",
                                style: FontStylesResources.buttonStyle.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              )
                            else
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                                      color: Theme.of(context).colorScheme.primary,
                                      strokeWidth: 3,
                                      strokeCap: StrokeCap.round,
                                      value: _progress,
                                    ),
                                    Icon(
                                      Icons.stop_rounded,
                                      size: 12,
                                      color: Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ));
                    },
                  ),
                ),
                //
                const SizedBox(width: SpacesResources.s4),
                //
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onOpenFile,
                    child: Text(
                      "تصفح",
                      style: FontStylesResources.buttonStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
