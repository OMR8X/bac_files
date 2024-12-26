import 'package:bac_files_admin/core/helpers/input_validator.dart';
import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/services/router/app_arguments.dart';
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
import 'package:go_router/go_router.dart';
import '../../../core/services/router/app_routes.dart';
import '../../../core/widgets/ui/fields/list_selection_widget.dart';
import '../../../features/managers/domain/entities/file_section.dart';

class SetUpFileView extends StatefulWidget {
  const SetUpFileView({
    super.key,
    required this.arguments,
  });
  final SetUpFileArguments arguments;
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
    _titleController = TextEditingController(text: widget.arguments.bacFile?.title);
    //
    _bacFile = widget.arguments.bacFile ?? BacFile.empty();
    //
    _path = widget.arguments.path;
    //
    _size = widget.arguments.bacFile?.size;
    //
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SetUpFileView oldWidget) {
    //
    if (oldWidget.arguments.bacFile?.title != widget.arguments.bacFile?.title) {
      _titleController.text = widget.arguments.bacFile?.title ?? '';
    }
    //
    if (oldWidget.arguments.bacFile != widget.arguments.bacFile) {
      _bacFile = _bacFile.copyWith(
        title: widget.arguments.bacFile?.title ?? _bacFile.title,
        year: widget.arguments.bacFile?.year ?? _bacFile.year,
        sectionId: widget.arguments.bacFile?.sectionId ?? _bacFile.sectionId,
        materialId: widget.arguments.bacFile?.materialId ?? _bacFile.materialId,
        teacherId: widget.arguments.bacFile?.teacherId ?? _bacFile.teacherId,
        schoolId: widget.arguments.bacFile?.schoolId ?? _bacFile.schoolId,
      );
    }
    //
    if (widget.arguments.bacFile?.size.isNotEmpty ?? false) {
      _size = widget.arguments.bacFile?.size;
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
              onPressed: () async {
                context.push(AppRoutes.localPdfFile.path, extra: _path);
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///

              if (!widget.arguments.isUpdating)
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
                    if (file?.path != null && widget.arguments.onChangeFilePath != null) {
                      widget.arguments.onChangeFilePath!(file!.path!);
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
                loading: widget.arguments.isLoading,
                onPressed: () {
                  if (_path == null && !widget.arguments.isUpdating) {
                    Fluttertoast.showToast(msg: 'يرجى اختيار ملف');
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    //
                    _formKey.currentState!.save();
                    //
                    _bacFile = _bacFile.copyWith(size: (_size ?? 0).toString());
                    //
                    if (widget.arguments.isUpdating) {
                      widget.arguments.onSubmit(_bacFile, "");
                    } else {
                      widget.arguments.onSubmit(_bacFile, _path!);
                    }
                  }
                },
              ),
              const SizedBox(height: SpacesResources.s10),
            ],
          ),
        ),
      ),
    );
  }
}
