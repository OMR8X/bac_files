import 'package:bac_files_admin/core/helpers/input_validator.dart';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/drop_down_widget.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/files_attachment_widget.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/text_form_field_widget.dart';
import 'package:bac_files_admin/features/files/domain/entities/bac_file.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';

import '../../../core/widgets/ui/fields/list_selection_widget.dart';
import '../../../features/managers/domain/entities/file_section.dart';

class SetUpFileView extends StatefulWidget {
  const SetUpFileView({
    super.key,
    this.isLoading = false,
    this.isUpdating = false,
    this.path,
    this.bacFile,
    required this.onSubmit,
    this.onChangeFilePath,
  });
  final bool isLoading, isUpdating;
  final String? path;
  final BacFile? bacFile;
  final void Function(BacFile file, String path) onSubmit;
  final void Function(String path)? onChangeFilePath;
  @override
  State<SetUpFileView> createState() => _SetUpFileViewState();
}

/*
*/
class _SetUpFileViewState extends State<SetUpFileView> {
  late String? _size;
  late String? _path;
  late BacFile _bacFile;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _titleController;

  @override
  void initState() {
    //
    _formKey = GlobalKey<FormState>();
    //
    _titleController = TextEditingController(text: widget.bacFile?.title);
    //
    _bacFile = widget.bacFile ?? BacFile.empty();
    //
    _path = widget.path;
    //
    _size = widget.bacFile?.size;
    //
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SetUpFileView oldWidget) {
    //
    if (oldWidget.bacFile?.title != widget.bacFile?.title) {
      _titleController.text = widget.bacFile?.title ?? '';
    }
    //
    if (oldWidget.bacFile != widget.bacFile) {
      _bacFile = _bacFile.copyWith(
        title: widget.bacFile?.title ?? _bacFile.title,
        year: widget.bacFile?.year ?? _bacFile.year,
        sectionId: widget.bacFile?.sectionId ?? _bacFile.sectionId,
        materialId: widget.bacFile?.materialId ?? _bacFile.materialId,
        teacherId: widget.bacFile?.teacherId ?? _bacFile.teacherId,
        schoolId: widget.bacFile?.schoolId ?? _bacFile.schoolId,
      );
    }
    //
    if (widget.bacFile?.size.isNotEmpty ?? false) {
      _size = widget.bacFile?.size;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_path?.isNotEmpty ?? false)
            IconButton(
              icon: Icon(
                Icons.open_in_new,
                size: 25,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                OpenFile.open(_path);
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ///

            if (!widget.isUpdating)
              FileAttachmentWidget(
                filePath: _path,
                afterPick: ({file}) {
                  //
                  setState(() {
                    _path = file?.path;
                    _size = (file?.size ?? 0).toString();

                    _bacFile = _bacFile.copyWith(
                      extension: file?.extension ?? "",
                    );
                  });
                  //
                  if (file?.path != null && widget.onChangeFilePath != null) {
                    widget.onChangeFilePath!(file!.path!);
                  }
                },
              ),

            ///
            TextFormFieldWidget(
              hintText: "اسم الملف",
              controller: _titleController,
              validator: InputValidator.notEmptyValidator,
              onSaved: (p0) {
                _bacFile = _bacFile.copyWith(title: p0);
              },
            ),

            ///
            DropDownWidget<String>(
              hintText: "السنة",
              initialSelection: _bacFile.year,
              entries: (<String?>[null] + List.generate(15, (index) => "${DateTime.now().year - index}")),
              toLabel: (value) {
                return value ?? "غير محدد";
              },
              onSelected: (entry) {
                _bacFile = _bacFile.copyWith(
                  year: entry,
                  setYearNull: entry == null,
                );
              },
            ),

            ///
            DropDownWidget<FileSection>(
              hintText: "الفرع التعليمي",
              initialSelection: sl<FileManagers>().sectionById(
                id: _bacFile.sectionId,
              ),
              entries: sl<FileManagers>().sections,
              toLabel: (value) {
                return value?.name ?? "غير محدد";
              },
              onSelected: (entry) {
                _bacFile = _bacFile.copyWith(sectionId: entry?.id);
              },
            ),

            ///
            DropDownWidget<FileMaterial>(
              hintText: "المادة",
              initialSelection: sl<FileManagers>().materialById(
                id: _bacFile.materialId,
              ),
              entries: sl<FileManagers>().materials,
              toLabel: (value) {
                return value?.name ?? "غير محدد";
              },
              onSelected: (entry) {
                _bacFile = _bacFile.copyWith(materialId: entry?.id);
              },
            ),

            ///
            DropDownWidget<FileTeacher>(
              hintText: "المعلم",
              initialSelection: sl<FileManagers>().teacherById(
                id: _bacFile.teacherId,
                nullable: true,
              ),
              entries: <FileTeacher?>[null] + sl<FileManagers>().teachers,
              toLabel: (value) {
                return value?.name ?? "غير محدد";
              },
              onSelected: (entry) {
                _bacFile = _bacFile.copyWith(
                  teacherId: entry?.id,
                  setTeacherNull: entry == null,
                );
              },
            ),

            ///
            DropDownWidget<FileSchool>(
              hintText: "مدرسة/مركز",
              initialSelection: sl<FileManagers>().schoolById(
                id: _bacFile.schoolId,
                nullable: true,
              ),
              entries: <FileSchool?>[null] + sl<FileManagers>().schools,
              toLabel: (value) {
                return value?.name ?? "غير محدد";
              },
              onSelected: (entry) {
                _bacFile = _bacFile.copyWith(
                  schoolId: entry?.id,
                  setSchoolNull: entry == null,
                );
              },
            ),

            ///
            ListSelectionWidget<FileCategory>(
              title: "تحديد التصانيف",
              context: context,
              toText: (category) => category.name,
              items: sl<FileManagers>().categories,
              selectedItems: sl<FileManagers>().categoriesByIds(ids: _bacFile.categoriesIds),
              onSelect: (categories) {
                _bacFile = _bacFile.copyWith(
                  categoriesIds: categories.map((e) => e.id).toList(),
                );
              },
            ),

            ///
            ElevatedButtonWidget(
              title: "حفظ",
              loading: widget.isLoading,
              onPressed: () {
                if (_path == null && !widget.isUpdating) {
                  Fluttertoast.showToast(msg: 'يرجى اختيار ملف');
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  //
                  _formKey.currentState!.save();
                  //
                  _bacFile = _bacFile.copyWith(size: (_size ?? 0).toString());
                  //
                  if (widget.isUpdating) {
                    widget.onSubmit(_bacFile, "");
                  } else {
                    widget.onSubmit(_bacFile, _path!);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
