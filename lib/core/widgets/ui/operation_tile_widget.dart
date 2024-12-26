import 'dart:async';

import 'package:bac_files_admin/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_files_admin/core/widgets/dialogs/conform_dialog.dart';
import 'package:bac_files_admin/features/operations/domain/entities/operation_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../resources/styles/border_radius_resources.dart';
import '../../resources/styles/decoration_resources.dart';
import '../../resources/styles/font_styles_manager.dart';
import '../../resources/styles/padding_resources.dart';
import '../../resources/styles/sizes_resources.dart';
import '../../resources/styles/spaces_resources.dart';
import '../dialogs/cancel_item_dialog.dart';
import '../../../features/operations/domain/entities/operation.dart';
import '../../../features/operations/domain/entities/operation_state.dart';

class OperationTileWidget extends StatefulWidget {
  const OperationTileWidget({
    super.key,
    required this.operation,
    this.onUpload,
    this.onEdit,
    this.onStop,
    this.onDelete,
    this.onExplore,
  });
  //
  final Operation operation;
  //
  final void Function(Operation operation)? onUpload;
  final void Function(Operation operation)? onEdit;
  final void Function(Operation operation)? onStop;
  final void Function(Operation operation)? onDelete;
  //
  final VoidCallback? onExplore;

  @override
  State<OperationTileWidget> createState() => _OperationTileWidgetState();
}

class _OperationTileWidgetState extends State<OperationTileWidget> {
  //
  double _progress = 0.0;
  //
  StreamSubscription? _progressSubscription;
  StreamSubscription? _completeSubscription;
  StreamSubscription? _failedSubscription;
  //
  @override
  void initState() {
    //
    _progressSubscription = FlutterBackgroundService().on("on-progress").listen((data) {
      //
      final operationId = data!['operation_id'] as int;
      final fileId = data['file_id'] as String;
      //
      if (operationId == widget.operation.id || fileId == widget.operation.file.id) {
        setState(() => _progress = (data['sent'] as int) / (data['total'] as int));
      }
      //
    });
    //
    super.initState();
  }

  @override
  void didUpdateWidget(covariant OperationTileWidget oldWidget) {
    if (oldWidget.operation.state != widget.operation.state) {
      setState(() {
        _progress = 0.0;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _progressSubscription?.cancel();
    _completeSubscription?.cancel();
    _failedSubscription?.cancel();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: SizesResources.mainWidth(context),
          decoration: DecorationResources.tileDecoration(theme: Theme.of(context)),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: PaddingResources.padding_4_4,
              child: Row(
                children: [
                  ///
                  const _FileExtensionIconWidget(extension: 'PDF'),

                  ///
                  const SizedBox(width: SpacesResources.s4),

                  ///
                  _DetailsWidget(
                    operation: widget.operation,
                    progress: _progress,
                  ),

                  ///
                  if (widget.operation.state == OperationState.initializing)
                    _ProcessIconWidget(
                      type: widget.operation.type,
                      onPressed: () {
                        if (widget.onUpload == null) return;
                        widget.onUpload!(widget.operation);
                      },
                    ),

                  ///
                  if (widget.operation.state == OperationState.failed) ...[
                    _RetryIconWidget(
                      onPressed: () {
                        if (widget.onUpload == null) return;
                        widget.onUpload!(widget.operation);
                      },
                    ),
                    _ErrorDetailsIconWidget(
                      onPressed: () {
                        showConformDialog(
                          context: context,
                          onConform: () {},
                          title: "تفاصيل الخطأ",
                          body: widget.operation.error ?? "لا يوجد تفاصيل",
                          action: "موافق",
                        );
                      },
                    )
                  ],

                  ///
                  if ([OperationState.initializing, OperationState.created].contains(widget.operation.state) && ![OperationType.download].contains(widget.operation.type))
                    _EditIconWidget(
                      onPressed: () {
                        if (widget.onEdit == null) return;
                        widget.onEdit!(widget.operation);
                      },
                    ),

                  ///
                  if ([OperationState.succeed].contains(widget.operation.state) && widget.onExplore != null && widget.operation.type == OperationType.download)
                    _ExploreIconWidget(
                      onPressed: widget.onExplore!,
                    ),

                  ///
                  if ([OperationState.pending, OperationState.uploading].contains(widget.operation.state))
                    _StopIconWidget(
                      onPressed: () {
                        if (widget.onStop == null) return;
                        widget.onStop!(widget.operation);
                      },
                    ),

                  ///
                  if ([OperationState.initializing, OperationState.succeed, OperationState.failed, OperationState.created].contains(widget.operation.state))
                    _DeleteIconWidget(
                      state: widget.operation.state,
                      onPressed: () {
                        //
                        if (widget.onDelete == null) return;
                        //
                        if (widget.operation.state == OperationState.succeed) {
                          widget.onDelete!(widget.operation);
                          return;
                        }
                        //
                        showCancelItemDialog(
                          context: context,
                          item: widget.operation.file.title,
                          onConform: () {
                            widget.onDelete!(widget.operation);
                          },
                        );
                      },
                    ),
                ],
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
    required this.progress,
    required this.operation,
  });
  final double progress;
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: PaddingResources.padding_2_1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///
            Row(
              children: [
                Expanded(
                  child: Text(
                    operation.file.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStylesResources.tileTitleStyle(context),
                  ),
                ),
              ],
            ),

            ///
            if ([OperationState.uploading, OperationState.pending].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s4),
              LinearProgressIndicator(
                borderRadius: BorderRadiusResource.bordersRadiusTiny,
                backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
                value: progress,
              ),
              const SizedBox(height: SpacesResources.s1),
            ],

            ///
            if ([OperationState.initializing, OperationState.uploading].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s2),
              Text(
                '${(int.parse(operation.file.size) / (1024 * 1024)).toStringAsFixed(2)} MB',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: FontSizeResources.s10,
                ),
              ),
            ],

            ///
            if ([OperationState.succeed].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s4),
              Text(
                'تمت العملية بنجاح',
                style: FontStylesResources.tileSubTitleStyle(context).copyWith(
                  color: Theme.of(context).extension<SuccessColors>()!.success,
                ),
              ),
            ],

            ///
            if ([OperationState.failed].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s4),
              Text(
                'فشلت العملية',
                style: FontStylesResources.tileSubTitleStyle(context).copyWith(
                  color: Theme.of(context).colorScheme.errorContainer,
                ),
              ),
            ],

            ///
            if (operation.state == OperationState.pending) ...[
              const SizedBox(height: SpacesResources.s4),
              Text(
                progress > 0 ? "%${(progress * 100).toStringAsFixed(2)}" : 'قائمة الأنتظار',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: FontSizeResources.s10,
                ),
              ),
            ],
          ],
        ),
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
        borderRadius: BorderRadiusResource.iconBorderRadius,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      width: 35,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.only(top: SpacesResources.s1),
        child: Text(
          extension,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeightResources.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _RetryIconWidget extends StatelessWidget {
  const _RetryIconWidget({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.refresh_rounded,
        size: 12,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}

class _ErrorDetailsIconWidget extends StatelessWidget {
  const _ErrorDetailsIconWidget({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.details,
        size: 12,
        color: Theme.of(context).colorScheme.errorContainer,
      ),
    );
  }
}

class _ProcessIconWidget extends StatelessWidget {
  const _ProcessIconWidget({required this.onPressed, required this.type});
  final OperationType type;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        type == OperationType.download ? Icons.download : Icons.upload,
        size: 12,
        color: Theme.of(context).colorScheme.primaryContainer,
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
        backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.edit,
        size: 12,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}

class _DeleteIconWidget extends StatelessWidget {
  const _DeleteIconWidget({required this.onPressed, required this.state});
  final OperationState state;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.close,
        size: 12,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _StopIconWidget extends StatelessWidget {
  const _StopIconWidget({required this.onPressed});
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
        Icons.pause,
        size: 12,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _ExploreIconWidget extends StatelessWidget {
  const _ExploreIconWidget({required this.onPressed});
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
        Icons.visibility,
        size: 12,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
