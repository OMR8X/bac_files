import 'package:bac_files_admin/presentation/files/state/explore_file/explore_file_bloc.dart';
import 'package:bac_files_admin/presentation/files/views/file_information_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/injector/app_injection.dart';
import '../../../core/widgets/ui/loading_widget.dart';

class ExploreFileView extends StatefulWidget {
  const ExploreFileView({super.key, required this.fileId});
  final String fileId;
  @override
  State<ExploreFileView> createState() => _ExploreFileViewState();
}

class _ExploreFileViewState extends State<ExploreFileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<ExploreFileBloc>()..add(ExploreFileInitializeEvent(fileId: widget.fileId)),
        child: BlocConsumer<ExploreFileBloc, ExploreFileState>(
          listener: (context, state) {
            if (state.status == ExploreFileStatus.failed) {
              Fluttertoast.showToast(msg: state.failure!.message);
            }
          },
          builder: (context, state) {
            if (state.status == ExploreFileStatus.fetching) {
              return const LoadingWidget();
            }
            return FileInformationView(file: state.file);
          },
        ),
      ),
    );
  }
}
