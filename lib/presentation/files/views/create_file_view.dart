import 'package:bac_files/core/services/router/app_arguments.dart';
import 'package:bac_files/presentation/files/state/create_file/create_file_bloc.dart';
import 'package:bac_files/presentation/files/views/set_up_file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../core/injector/app_injection.dart';

class CreateFileView extends StatefulWidget {
  const CreateFileView({super.key});

  @override
  State<CreateFileView> createState() => _CreateFileViewState();
}

class _CreateFileViewState extends State<CreateFileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<CreateFileBloc>()..add(const CreateFileInitializeEvent()),
        child: BlocConsumer<CreateFileBloc, CreateFileState>(
          listener: (context, state) {
            if (state.status == CreateFileStatus.failure) {
              Fluttertoast.showToast(msg: state.failure!.message);
            }
            if (state.status == CreateFileStatus.success) {
              Fluttertoast.showToast(msg: "تم اضافة الملف الملف بنجاح");
              context.pop();
            }
          },
          builder: (context, state) {
            return SetUpFileView(
              arguments: SetUpFileArguments(
                isLoading: state.status == CreateFileStatus.loading,
                bacFile: state.bacFile,
                onChangeFilePath: (path) {
                  context.read<CreateFileBloc>().add(CreateFilePickFileEvent(path: path));
                },
                onSubmit: (file, path) {
                  context.read<CreateFileBloc>().add(CreateFileSubmitEvent(bacFile: file, path: path));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
