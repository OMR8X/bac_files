import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/widgets/ui/fields/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/input_validator.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/ui/fields/check_title_widget.dart';
import '../../../core/widgets/ui/fields/elevated_button_widget.dart';
import '../state/bloc/auth_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.state});
  final AuthSigningInState state;
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  //
  late final GlobalKey<FormState> _formKey;
  //
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  //
  @override
  void initState() {
    //
    _formKey = GlobalKey<FormState>();
    //
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    sl<AuthBloc>().add(
      AuthSignInEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الدخول"),
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
                  hintText: "البريد الإلكتروني",
                  maxLength: 64,
                  position: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (text) {
                    return InputValidator.emailValidator(text);
                  },
                ),
                TextFormFieldWidget(
                  hintText: "الرمز السري",
                  maxLength: 64,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  position: 2,
                  controller: _passwordController,
                  validator: (text) {
                    return InputValidator.passwordValidator(text);
                  },
                ),
                ElevatedButtonWidget(
                  title: "تسجيل الدخول",
                  loading: widget.state.loading,
                  position: 3,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _submit();
                    }
                  },
                  backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
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
