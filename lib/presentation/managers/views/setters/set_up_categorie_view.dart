import 'package:bac_files_admin/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:bac_files_admin/features/managers/domain/requests/create_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/update_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/create_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/update_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/create_teacher_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/update_teacher_usecase.dart';
import 'package:bac_files_admin/presentation/managers/state/managers_view/managers_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../core/widgets/ui/fields/text_form_field_widget.dart';

class SetUpCategoryView extends StatefulWidget {
  const SetUpCategoryView({super.key, this.category});
  final FileCategory? category;
  @override
  State<SetUpCategoryView> createState() => _SetUpCategoriesViewState();
}

class _SetUpCategoriesViewState extends State<SetUpCategoryView> {
  ///
  bool isLoading = false;

  ///
  late final GlobalKey<FormState> _formKey;

  ///
  late final TextEditingController _nameController;

  ///
  onAddCategory() async {
    ///
    setState(() => isLoading = true);
    final response = await sl<CreateCategoryUseCase>().call(
      request: CreateEntityRequest(entity: FileCategory(name: _nameController.text)),
    );

    ///
    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        setState(() => isLoading = false);
      },
      (success) async {
        //
        Fluttertoast.showToast(msg: success.message);
        //
        sl<ManagersViewBloc>().add(const ManagersViewUpdateEvent());
        //
        if (mounted) {
          context.pop();
        }
      },
    );
  }

  ///
  onUpdateCategory() async {
    ///
    setState(() => isLoading = true);

    final response = await sl<UpdateCategoryUseCase>().call(
      request: UpdateEntityRequest(
        id: widget.category!.id,
        entity: FileCategory(name: _nameController.text),
      ),
    );

    ///
    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
        setState(() => isLoading = false);
      },
      (success) async {
        //
        Fluttertoast.showToast(msg: success.message);
        //
        sl<ManagersViewBloc>().add(const ManagersViewUpdateEvent());
        //
        if (mounted) {
          context.pop();
        }
      },
    );
  }

  ///
  @override
  void initState() {
    //
    _formKey = GlobalKey<FormState>();
    //
    _nameController = TextEditingController(text: widget.category?.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("اعداد المعلومات"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _NameField(controller: _nameController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _Button(
        isLoading: isLoading,
        onPressed: () {
          if (widget.category == null) {
            onAddCategory();
          } else {
            onUpdateCategory();
          }
        },
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      hintText: "اسم التصنيف",
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.isLoading, required this.onPressed});
  final bool isLoading;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButtonWidget(
        title: "حفظ",
        loading: isLoading,
        onPressed: onPressed,
      ),
    );
  }
}
