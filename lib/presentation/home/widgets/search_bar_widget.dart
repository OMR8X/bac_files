import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/decoration_resources.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/sizes_resources.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizesResources.mainWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: PaddingResources.padding_0_5,
              decoration: DecorationResources.inputFieldDecoration(
                theme: Theme.of(context),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                style: FontStylesResources.textFieldStyle,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
