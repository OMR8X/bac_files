import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/input_validator.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/ui/fields/elevated_button_widget.dart';
import '../../../core/widgets/ui/fields/text_form_field_widget.dart';
import '../state/bloc/auth_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.state});
  final AuthSigningUpState state;
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
    _formKey = GlobalKey<FormState>();
    //
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
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
    sl<AuthBloc>().add(
      AuthSignUpEvent(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("انشاء حساب جديد"),
        leading: IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthStartAuthEvent());
          },
          icon: const Icon(Icons.close),
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
                    return InputValidator.passwordValidator(text);
                  },
                ),
                ElevatedButtonWidget(
                  title: "انشاء حساب",
                  loading: widget.state.loading,
                  position: 5,
                  backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _submit();
                    }
                  },
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
