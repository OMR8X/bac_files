import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/resources/styles/colors_resources.dart';
import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:flutter/material.dart';

import '../../../resources/styles/sizes_resources.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.initialSelection,
    required this.entries,
    required this.toLabel,
    required this.onSelected,
    this.hintText,
  });
  final String? hintText;
  final T? initialSelection;
  final List<T?> entries;
  final String Function(T? value) toLabel;
  final void Function(T? entry)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: PaddingResources.padding_0_4,
          child: Container(
            width: SizesResources.mainWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
              borderRadius: BorderRadiusResource.fieldBorderRadius,
            ),
            child: DropdownMenu(
              textStyle: FontStylesResources.buttonStyle,
              hintText: hintText,
              label: hintText != null ? Text(hintText!) : null,
              width: SizesResources.mainWidth(context),
              initialSelection: initialSelection,
              onSelected: (item) {
                if (onSelected != null) {
                  item != initialSelection ? onSelected!(item) : onSelected!(null);
                }
              },
              dropdownMenuEntries: entries.map((e) {
                return DropdownMenuEntry<T?>(
                  value: e,
                  label: toLabel(e),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
