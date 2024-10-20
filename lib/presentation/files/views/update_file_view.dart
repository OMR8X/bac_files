import 'package:bac_files_admin/core/widgets/ui/loading_widget.dart';
import 'package:bac_files_admin/presentation/files/state/update_file/update_file_bloc.dart';
import 'package:bac_files_admin/presentation/files/views/set_up_file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';

class UpdateFileView extends StatefulWidget {
  const UpdateFileView({super.key, required this.fileId});
  final String fileId;
  @override
  State<UpdateFileView> createState() => _UpdateFileViewState();
}

class _UpdateFileViewState extends State<UpdateFileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<UpdateFileBloc>()..add(UpdateFileInitializeEvent(fileId: widget.fileId)),
        child: BlocConsumer<UpdateFileBloc, UpdateFileState>(
          listener: (context, state) {
            if (state.status == UpdateFileStatus.failure) {
              Fluttertoast.showToast(msg: state.failure!.message);
            }
            if (state.status == UpdateFileStatus.success) {
              Fluttertoast.showToast(msg: "تم تحديث الملف بنجاح");
              context.pop();
            }
          },
          builder: (context, state) {
            if (state.status == UpdateFileStatus.fetching) {
              return const LoadingWidget();
            }
            return SetUpFileView(
              isLoading: state.status == UpdateFileStatus.loading,
              isUpdating: true,
              bacFile: state.bacFile,
              onSubmit: (file, path) {
                context.read<UpdateFileBloc>().add(UpdateFileEditEvent(bacFile: file));
                context.read<UpdateFileBloc>().add(const UpdateFileUploadEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
