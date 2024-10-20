import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/errors/failures.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/files/domain/usecases/upload_file_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/functions/extractors/extract_relevent_element_function.dart';
import '../../../../core/functions/formatters/normalize_file_name.dart';
import '../../../../features/managers/domain/entities/file_material.dart';
import '../../../../features/managers/domain/entities/file_section.dart';
import '../../../../features/managers/domain/entities/school.dart';
import '../../../../features/managers/domain/entities/teacher.dart';
import '../../../../features/uploads/domain/entities/upload_operation.dart';
import '../../../uploads/state/uploads/uploads_bloc.dart';

part 'create_file_event.dart';
part 'create_file_state.dart';

class CreateFileBloc extends Bloc<CreateFileEvent, CreateFileState> {
  //
  CreateFileBloc() : super(CreateFileState.initial()) {
    on<CreateFileInitializeEvent>(onCreateFileInitializeEvent);
    on<CreateFilePickFileEvent>(onCreateFilePickFileEvent);
    on<CreateFileSubmitEvent>(onCreateFileUploadEvent);
  }
  onCreateFileInitializeEvent(CreateFileInitializeEvent event, Emitter<CreateFileState> emit) {
    emit(CreateFileState.initial());
  }

  onCreateFilePickFileEvent(CreateFilePickFileEvent event, Emitter<CreateFileState> emit) {
    //
    String actual = normalizeFileName(event.path.split("/").last.split(".").first);

    final String? year = extractRelevantElement<String>(actual, List.generate(10, (i) => (DateTime.now().year - i).toString()), (m) {
      return m;
    });
    //
    final FileMaterial? material = extractRelevantElement<FileMaterial>(actual, sl<FileManagers>().materials, (m) {
      return m.name;
    });
    //
    final FileSchool? school = extractRelevantElement<FileSchool>(actual, sl<FileManagers>().schools, (e) {
      return e.name;
    });
    //
    final FileSection? section = extractRelevantElement<FileSection>(actual, sl<FileManagers>().sections, (e) {
      return e.name;
    });
    //
    final FileTeacher? teacher = extractRelevantElement<FileTeacher>(actual, sl<FileManagers>().teachers, (e) {
      return e.name;
    });
    //
    emit(state.copyWith(
      bacFile: state.bacFile.copyWith(
        title: actual,
        year: year,
        sectionId: section?.id,
        materialId: material?.id,
        teacherId: teacher?.id,
        schoolId: school?.id,
      ),
    ));
  }

  onCreateFileUploadEvent(CreateFileSubmitEvent event, Emitter<CreateFileState> emit) async {
    //
    emit(state.copyWith(status: CreateFileStatus.loading));
    //
    UploadOperation operation = UploadOperation(
      id: 0,
      path: event.path,
      file: event.bacFile,
      state: OperationState.initializing,
    );
    //
    sl<UploadsBloc>().add(AddOperationEvent(operation: operation));
    //
    emit(state.copyWith(status: CreateFileStatus.success));
  }
}
