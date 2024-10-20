import 'package:flutter/material.dart';

import '../../../resources/styles/colors_resources.dart';
import '../../../resources/styles/decoration_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/padding_resources.dart';
import '../../../resources/styles/sizes_resources.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText = false,
    this.textInputAction,
  });
  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingResources.padding_0_4,
      width: SizesResources.mainWidth(context),
      decoration: DecorationResources.inputFieldDecoration(
        theme: Theme.of(context),
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        obscureText: obscureText && obscureText,
        textInputAction: textInputAction ?? TextInputAction.next,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: " $hintText",
          hintStyle: const TextStyle(
            fontWeight: FontWeightResources.regular,
          ),
        ),
      ),
    );
  }
}
