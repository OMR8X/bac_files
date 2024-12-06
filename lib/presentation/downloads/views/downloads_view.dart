import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:bac_files_admin/presentation/downloads/state/downloads/downloads_bloc.dart';
import 'package:bac_files_admin/core/widgets/ui/operation_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({super.key});

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadsBloc, DownloadsState>(
      ///
      listener: (context, state) {
        if (state.status == DownloadStatus.failure) {
          Fluttertoast.showToast(msg: state.failure!.message);
        }
      },

      ///
      builder: (context, state) {
        return Scaffold(
          ///
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "عمليات التحميل",
                ),
                const SizedBox(height: SpacesResources.s4),
                Text(
                  "عدد العمليات : ${state.operations.length}",
                  style: FontStylesResources.tileSubTitleStyle(context),
                ),
              ],
            ),
            centerTitle: false,
            actions: const [
              // ///
              // if (state.operations.any((e) => [OperationState.initializing].contains(e.state)))
              //   TextButton(
              //     onPressed: () {
              //       sl<DownloadsBloc>().add(const StartAllOperationsEvent());
              //     },
              //     child: const Text("رفع الكل", style: FontStylesResources.appBarButtonStyle),
              //   ),

              // ///
              // if (state.operations.any((e) => [OperationState.uploading, OperationState.pending].contains(e.state)))
              //   TextButton(
              //     onPressed: () {
              //       sl<DownloadsBloc>().add(const StopAllOperationEvent());
              //     },
              //     child: const Text(
              //       "ايقاف الكل",
              //       style: FontStylesResources.appBarButtonStyle,
              //     ),
              //   ),

              // ///
              // if (state.operations.every((e) => [OperationState.initializing, OperationState.created, OperationState.failed, OperationState.succeed].contains(e.state)) && state.operations.isNotEmpty)
              //   TextButton(
              //     onPressed: () {
              //       showConformDialog(
              //         context: context,
              //         title: "حذف كل العمليات",
              //         body: "هل تريد حذف كل العمليات؟",
              //         action: "حذف الكل",
              //         onConform: () {
              //           sl<DownloadsBloc>().add(const DeleteAllOperationsEvent());
              //         },
              //       );
              //     },
              //     child: Text(
              //       "حذف الكل",
              //       style: FontStylesResources.appBarButtonStyle.copyWith(
              //         color: Theme.of(context).colorScheme.error,
              //       ),
              //     ),
              //   ),
            ],
          ),

          ///
          body: Stack(
            children: [
              AnimationLimiter(
                child: ListView.builder(
                  padding: PaddingResources.padding_0_4.copyWith(
                    bottom: SpacesResources.s40,
                  ),
                  itemCount: state.operations.length,
                  itemBuilder: (context, index) {
                    return StaggeredListWrapperWidget(
                      key: ValueKey(state.operations[index].path),
                      position: index,
                      child: OperationTileWidget(
                        operation: state.operations[index],
                        onExplore: () async {
                          context.push(AppRoutes.localPdfFile.path, extra: state.operations[index].path);
                        },
                        onUpload: (operation) {
                          sl<DownloadsBloc>().add(StartOperationEvent(operation: operation));
                        },
                        onDelete: (operation) {
                          sl<DownloadsBloc>().add(DeleteOperationEvent(operation: operation));
                        },
                        onStop: (operation) {
                          sl<DownloadsBloc>().add(StopOperationEvent(operation: operation));
                        },
                        onEdit: (operation) {
                          context.push(AppRoutes.updateOperationFile.path, extra: operation.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class _StartAllIconWidget extends StatelessWidget {
//   const _StartAllIconWidget({required this.onPressed});
//   final void Function()? onPressed;
//   @override
//   Widget build(BuildContext context) {
//     return IconButton.filled(
//       style: IconButton.styleFrom(
//         backgroundColor: Theme.of(context).colorScheme.onPrimary,
//         minimumSize: const Size(SizesResources.sizeUnit * 10, SizesResources.sizeUnit * 10),
//       ),
//       onPressed: onPressed,
//       icon: Icon(
//         Icons.arrow_upward_outlined,
//         size: 15,
//         color: Theme.of(context).colorScheme.primary,
//       ),
//     );
//   }
// }
