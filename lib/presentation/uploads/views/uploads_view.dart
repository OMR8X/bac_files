import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/services/cache/cache_client.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/core/services/debug/debugging_manager.dart';
import 'package:bac_files_admin/core/services/router/index.dart';
import 'package:bac_files_admin/core/widgets/dialogs/conform_dialog.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/presentation/uploads/state/uploads/uploads_bloc.dart';
import 'package:bac_files_admin/presentation/uploads/widgets/upload_operation_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/sizes_resources.dart';

class UploadsView extends StatefulWidget {
  const UploadsView({super.key});

  @override
  State<UploadsView> createState() => _UploadsViewState();
}

class _UploadsViewState extends State<UploadsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UploadsBloc>()..add(const InitializeOperationsEvent()),
      child: BlocConsumer<UploadsBloc, UploadsState>(
        listener: (context, state) {
          if (state.status == UploadsStatus.failure) {
            Fluttertoast.showToast(msg: state.failure!.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("عمليات الرفع"),
              actions: [
                if (state.operations.any((e) => [OperationState.initializing].contains(e.state)))
                  TextButton(
                    onPressed: () {
                      sl<UploadsBloc>().add(const StartAllOperationsEvent());
                    },
                    child: const Text("رفع الكل"),
                  ),
                if (state.operations.any((e) => [OperationState.uploading, OperationState.pending].contains(e.state)))
                  TextButton(
                    onPressed: () {
                      sl<UploadsBloc>().add(const StopAllOperationEvent());
                    },
                    child: const Text("ايقاف الكل"),
                  ),
                // TextButton(
                //   onPressed: () {
                //     sl<UploadsBloc>().add(const RefreshOperationEvent());
                //   },
                //   child: const Text("تحديث"),
                // ),
              ],
            ),
            body: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.operations.length,
                    itemBuilder: (context, index) {
                      return UploadOperationTileWidget(
                        operation: state.operations[index],
                        onUpload: (operation) {
                          sl<UploadsBloc>().add(StartOperationEvent(operation: operation));
                        },
                        onDelete: (operation) {
                          sl<UploadsBloc>().add(DeleteOperationEvent(operation: operation));
                        },
                        onStop: (operation) {
                          sl<UploadsBloc>().add(StopOperationEvent(operation: operation));
                        },
                        onEdit: (operation) {
                          context.push(AppRoutes.updateOperationFile.path, extra: operation.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusResource.buttonBorderRadius,
              ),
              onPressed: () async {
                context.push(AppRoutes.createFile.path);
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          );
        },
      ),
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
