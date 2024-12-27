import 'package:bac_files/core/injector/app_injection.dart';
import 'package:bac_files/core/resources/styles/padding_resources.dart';
import 'package:bac_files/core/resources/styles/sizes_resources.dart';
import 'package:bac_files/core/resources/styles/spaces_resources.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:flutter/material.dart';

import '../../resources/styles/border_radius_resources.dart';
import '../../resources/themes/extensions/surface_container_colors.dart';

showCategoriesSelectionDialog({
  required BuildContext context,
  required List<String> selectedItems,
  required void Function(List<String> items) onSubmit,
}) {
  List<String> selectedItems0 = selectedItems;
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: SizedBox(
          width: SizesResources.mainHalfWidth(context),
          height: SizesResources.mainWidth(context) * 1.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              const SizedBox(
                height: SpacesResources.s15,
              ),

              ///
              const Padding(
                padding: PaddingResources.padding_1_0,
                child: Text(
                  "تحديد التصانيف",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              ///
              const SizedBox(
                height: SpacesResources.s10,
              ),

              ///
              _ItemsSelector(
                selectedItems: selectedItems,
                onUpdate: (items) {
                  selectedItems0 = items;
                },
              ),

              const Divider(
                height: 1,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        onSubmit(selectedItems0);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "تحديد",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ItemsSelector extends StatefulWidget {
  const _ItemsSelector({
    super.key,
    required this.selectedItems,
    required this.onUpdate,
  });
  final void Function(List<String> items) onUpdate;
  final List<String> selectedItems;
  @override
  State<_ItemsSelector> createState() => __ItemsSelectorState();
}

class __ItemsSelectorState extends State<_ItemsSelector> {
  late final List<String> _selectedItems;
  @override
  void initState() {
    _selectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

        ///
        Expanded(
      child: ListView.builder(
        padding: PaddingResources.padding_1_1,
        itemCount: sl<FileManagers>().categories.length,
        itemBuilder: (context, index) {
          final item = sl<FileManagers>().categories[index];
          final isSelected = _selectedItems.contains(item.id);
          return Container(
            height: 55,
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: SpacesResources.s4,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadiusResource.tileBorderRadius,
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadiusResource.tileBorderRadius,
              child: InkWell(
                borderRadius: BorderRadiusResource.tileBorderRadius,
                onTap: () {
                  bool value = !isSelected;
                  setState(() {
                    if (value == true) {
                      _selectedItems.add(item.id);
                    } else {
                      _selectedItems.remove(item.id);
                    }
                    widget.onUpdate(_selectedItems);
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedItems.add(item.id);
                          } else {
                            _selectedItems.remove(item.id);
                          }
                          widget.onUpdate(_selectedItems);
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
