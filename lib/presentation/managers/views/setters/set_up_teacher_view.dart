import 'package:bac_files_admin/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:bac_files_admin/features/managers/domain/requests/create_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/requests/update_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/create_teacher_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/update_teacher_usecase.dart';
import 'package:bac_files_admin/presentation/managers/state/managers_view/managers_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/injector/app_injection.dart';
import '../../../../core/widgets/ui/fields/text_form_field_widget.dart';

class SetUpTeacherView extends StatefulWidget {
  const SetUpTeacherView({super.key, this.teacher});
  final FileTeacher? teacher;
  @override
  State<SetUpTeacherView> createState() => _SetUpTeacherViewState();
}

class _SetUpTeacherViewState extends State<SetUpTeacherView> {
  ///
  bool isLoading = false;

  ///
  late final GlobalKey<FormState> _formKey;

  ///
  late final TextEditingController _nameController;

  ///
  onAddTeacher() async {
    ///
    setState(() => isLoading = true);
    final response = await sl<CreateTeacherUseCase>().call(
      request: CreateEntityRequest(entity: FileTeacher(name: _nameController.text)),
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
  onUpdateTeacher() async {
    ///
    setState(() => isLoading = true);

    final response = await sl<UpdateTeacherUseCase>().call(
      request: UpdateEntityRequest(
        id: widget.teacher!.id,
        entity: FileTeacher(name: _nameController.text),
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
    _nameController = TextEditingController(text: widget.teacher?.name);
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
          if (widget.teacher == null) {
            onAddTeacher();
          } else {
            onUpdateTeacher();
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
      hintText: "اسم المعلم",
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
