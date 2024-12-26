import 'dart:math';

import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/input_validator.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/ui/fields/elevated_button_widget.dart';
import '../../../core/widgets/ui/fields/text_form_field_widget.dart';
import '../state/bloc/auth_bloc.dart';

class UpdateUserDataView extends StatefulWidget {
  const UpdateUserDataView({
    super.key,
  });
  @override
  State<UpdateUserDataView> createState() => _UpdateUserDataViewState();
}

class _UpdateUserDataViewState extends State<UpdateUserDataView> {
  //
  late bool _didFillInfo = false;
  //
  late final GlobalKey<FormState> _formKey;
  //
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  //
  @override
  void initState() {
    //
    _didFillInfo = false;
    //
    _formKey = GlobalKey<FormState>();
    //
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    //
    initListeners();
    //
    super.initState();
  }

  initListeners() {
    //
    _nameController.addListener(() {
      if (_nameController.text.isNotEmpty) {
        setState(() => _didFillInfo = true);
      }
      if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
        if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
          setState(() => _didFillInfo = false);
        }
      }
    });
    //
    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() => _didFillInfo = true);
      }
      if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
        if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
          setState(() => _didFillInfo = false);
        }
      }
    });
    //
    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() => _didFillInfo = true);
      }
      if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
        if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
          setState(() => _didFillInfo = false);
        }
      }
    });
    //
    _confirmPasswordController.addListener(() {
      if (_confirmPasswordController.text.isNotEmpty) {
        setState(() => _didFillInfo = true);
      }
      if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
        if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
          setState(() => _didFillInfo = false);
        }
      }
    });
    //
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    //
    String? name = _nameController.text.isNotEmpty ? _nameController.text : null;
    String? email = _emailController.text.isNotEmpty ? _emailController.text : null;
    String? password = _passwordController.text.isNotEmpty ? _passwordController.text : null;
    //
    sl<AuthBloc>().add(
      AuthUpdateUserDataEvent(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغيير بيانات الحساب"),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.close,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: SpacesResources.s10),
                TextFormFieldWidget(
                  hintText: "الاسم",
                  position: 1,
                  keyboardType: TextInputType.name,
                  maxLength: 64,
                  controller: _nameController,
                  validator: (text) {
                    if (text?.isEmpty ?? true) return null;
                    return InputValidator.nameValidator(text);
                  },
                ),
                TextFormFieldWidget(
                  hintText: "البريد الإلكتروني",
                  maxLength: 64,
                  position: 2,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (text) {
                    if (text?.isEmpty ?? true) return null;
                    return InputValidator.emailValidator(text);
                  },
                ),
                TextFormFieldWidget(
                  hintText: "كلمة المرور",
                  maxLength: 64,
                  position: 3,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (text) {
                    if (text?.isEmpty ?? true) return null;
                    return InputValidator.passwordValidator(text);
                  },
                ),
                TextFormFieldWidget(
                  hintText: "تاكيد كلمة المرور",
                  maxLength: 64,
                  position: 4,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  validator: (text) {
                    if (_passwordController.text != _confirmPasswordController.text) {
                      return "كلمة المرور غير متطابقة";
                    }
                    if (text?.isEmpty ?? true) return null;
                    return InputValidator.passwordValidator(text);
                  },
                ),
                ElevatedButtonWidget(
                  title: "تغيير البيانات",
                  loading: false,
                  position: 5,
                  backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
                  onPressed: _didFillInfo
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _submit();
                          }
                        }
                      : null,
                ),
                const SizedBox(height: SpacesResources.s2),
                const Text(
                  "اترك اي حقل لا ترغب بتغييره فارغ",
                  style: FontStylesResources.underButtonStyle,
                ),
                const SizedBox(height: SpacesResources.s20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
