import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files_admin/core/widgets/dialogs/category_selection_dialog.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/sizes_resources.dart';
import '../../../core/widgets/dialogs/list_selection_dialog.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.selectedItems,
    required this.onFiltersSubmitted,
  });
  final List<String>? selectedItems;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(List<String> items) onFiltersSubmitted;
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
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      showCategoriesSelectionDialog(
                        context: context,
                        selectedItems: selectedItems ?? [],
                        onSubmit: onFiltersSubmitted,
                      );
                    },
                    icon: const Icon(Icons.filter_alt),
                  ),
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
