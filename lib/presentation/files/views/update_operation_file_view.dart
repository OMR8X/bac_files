import 'package:bac_files_admin/core/services/router/app_arguments.dart';
import 'package:bac_files_admin/core/widgets/ui/loading_widget.dart';
import 'package:bac_files_admin/presentation/files/state/update_file/update_file_bloc.dart';
import 'package:bac_files_admin/presentation/files/state/update_operation_file/update_operation_file_bloc.dart';
import 'package:bac_files_admin/presentation/files/views/set_up_file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';

class UpdateOperationFileView extends StatefulWidget {
  const UpdateOperationFileView({super.key, required this.operationId});
  final int operationId;
  @override
  State<UpdateOperationFileView> createState() => _UpdateOperationFileViewState();
}

class _UpdateOperationFileViewState extends State<UpdateOperationFileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<UpdateOperationFileBloc>()..add(UpdateOperationFileInitializeEvent(operationId: widget.operationId)),
        child: BlocConsumer<UpdateOperationFileBloc, UpdateOperationFileState>(
          listener: (context, state) {
            if (state.status == UpdateOperationFileStatus.failure) {
              Fluttertoast.showToast(msg: state.failure!.message);
            }
            if (state.status == UpdateOperationFileStatus.success) {
              Fluttertoast.showToast(msg: "تم تحديث الملف بنجاح");
              context.pop();
            }
          },
          builder: (context, state) {
            if (state.status == UpdateOperationFileStatus.fetching) {
              return const LoadingWidget();
            }
            return SetUpFileView(
              arguments: SetUpFileArguments(
                isLoading: state.status == UpdateOperationFileStatus.loading,
                isUpdating: true,
                bacFile: state.bacFile,
                path: state.operation.path,
                onSubmit: (file, path) {
                  context.read<UpdateOperationFileBloc>().add(UpdateOperationFileEditEvent(bacFile: file));
                  context.read<UpdateOperationFileBloc>().add(const UpdateOperationFileSaveEvent());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
