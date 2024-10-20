import 'dart:async';

import 'package:bac_files_admin/core/resources/themes/extensions/success_colors.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_files_admin/core/widgets/dialogs/conform_dialog.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:bac_files_admin/presentation/home/state/bloc/home_bloc.dart';
import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/border_radius_resources.dart';
import '../../../core/resources/styles/decoration_resources.dart';
import '../../../core/resources/styles/font_styles_manager.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/sizes_resources.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/widgets/dialogs/cancel_item_dialog.dart';

class UploadOperationTileWidget extends StatefulWidget {
  const UploadOperationTileWidget({
    super.key,
    required this.operation,
    this.onUpload,
    this.onEdit,
    this.onStop,
    this.onDelete,
  });
  //
  final UploadOperation operation;
  final void Function(UploadOperation operation)? onUpload;
  final void Function(UploadOperation operation)? onEdit;
  final void Function(UploadOperation operation)? onStop;
  final void Function(UploadOperation operation)? onDelete;

  @override
  State<UploadOperationTileWidget> createState() => _UploadOperationTileWidgetState();
}

class _UploadOperationTileWidgetState extends State<UploadOperationTileWidget> {
  //
  double _progress = 0.0;
  //
  late final StreamSubscription _progressSubscription;
  late final StreamSubscription _completeSubscription;
  late final StreamSubscription _failedSubscription;
  //
  @override
  void initState() {
    //
    _progressSubscription = FlutterBackgroundService().on("on-progress").listen((data) {
      //
      debugPrint("on-progress");
      //
      final operationId = data!['operation_id'] as int;
      //
      if (operationId == widget.operation.id) {
        setState(() => _progress = (data['sent'] as int) / (data['total'] as int));
      }
      //
    });
    //
    _completeSubscription = FlutterBackgroundService().on("on-completed").listen((data) {
      //
      debugPrint("on-completed");
      //
      final operationId = data!['operation_id'] as int;
      sl<UploadsBloc>().add(CompleteOperationEvent(operation: operationId));
      sl<HomeBloc>().add(const HomeLoadFilesEvent());
    });
    //
    _failedSubscription = FlutterBackgroundService().on("on-failed").listen((data) {
      //
      debugPrint("on-failed");
      //
      final operationId = data!['operation_id'] as int;
      sl<UploadsBloc>().add(FailedOperationEvent(operation: operationId));
    });
    super.initState();
  }

  @override
  void dispose() {
    _progressSubscription.cancel();
    _completeSubscription.cancel();
    _failedSubscription.cancel();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingResources.padding_5_2,
      width: SizesResources.mainWidth(context),
      decoration: DecorationResources.tileDecoration(theme: Theme.of(context)),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: PaddingResources.padding_3_3,
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
                _UploadIconWidget(
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
              if (widget.operation.state == OperationState.initializing)
                _EditIconWidget(
                  onPressed: () {
                    if (widget.onEdit == null) return;
                    widget.onEdit!(widget.operation);
                  },
                ),

              ///
              if ([OperationState.pending, OperationState.uploading].contains(widget.operation.state))
                _StopIconWidget(onPressed: () {
                  if (widget.onStop == null) return;
                  widget.onStop!(widget.operation);
                }),

              ///
              if ([OperationState.initializing, OperationState.succeed, OperationState.failed].contains(widget.operation.state))
                _DeleteIconWidget(
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
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({
    super.key,
    required this.progress,
    required this.operation,
  });
  final double progress;
  final UploadOperation operation;
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
                    style: TextStyle(
                      fontWeight: FontWeightResources.extraBold,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: FontSizeResources.s12,
                    ),
                  ),
                ),
                if ([OperationState.uploading].contains(operation.state))
                  Text(
                    "%${progress.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeightResources.light,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: FontSizeResources.s9,
                    ),
                  ),
              ],
            ),

            ///
            if ([OperationState.uploading, OperationState.pending].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s3),
              LinearProgressIndicator(
                borderRadius: BorderRadiusResource.bordersRadiusTiny,
                backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
                value: progress,
              ),
            ],

            ///
            if ([OperationState.initializing, OperationState.uploading].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s4),
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
                'تمت عملية الرفع بنجاح',
                style: TextStyle(
                  color: Theme.of(context).extension<SuccessColors>()!.success,
                  fontSize: FontSizeResources.s10,
                ),
              ),
            ],

            ///
            if ([OperationState.failed].contains(operation.state)) ...[
              const SizedBox(height: SpacesResources.s4),
              Text(
                'فشلت عملية الرفع',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: FontSizeResources.s10,
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

class _RetryIconWidget extends StatelessWidget {
  const _RetryIconWidget({required this.onPressed});
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
        Icons.refresh_rounded,
        size: 15,
        color: Theme.of(context).colorScheme.primary,
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
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.details,
        size: 15,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}

class _UploadIconWidget extends StatelessWidget {
  const _UploadIconWidget({required this.onPressed});
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
        Icons.upload,
        size: 15,
        color: Theme.of(context).colorScheme.primary,
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
      ),
      onPressed: onPressed,
      icon: Icon(
        Icons.close,
        size: 15,
        color: Theme.of(context).colorScheme.error,
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
        size: 15,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
