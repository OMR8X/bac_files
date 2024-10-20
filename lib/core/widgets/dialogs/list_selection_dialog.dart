import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:bac_files_admin/core/widgets/ui/fields/text_button_widget.dart';
import 'package:flutter/material.dart';

void listSelectionDialog<T>({
  required BuildContext context,
  required void Function(List<T>) onSelect,
  required String Function(T) toText,
  required List<T> items,
  required List<T> selectedItems,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: SizedBox(
          height: (MediaQuery.of(context).size.height) * (3 / 4),
          child: ItemsSelector<T>(
            onSelect: onSelect,
            toText: toText,
            items: items,
            selectedItems: selectedItems,
          ),
        ),
      );
    },
  );
}

class ItemsSelector<T> extends StatefulWidget {
  const ItemsSelector({
    super.key,
    required this.onSelect,
    required this.toText,
    required this.items,
    required this.selectedItems,
  });

  final void Function(List<T>) onSelect;
  final String Function(T item) toText;
  final List<T> items;
  final List<T> selectedItems;

  @override
  State<ItemsSelector<T>> createState() => _ItemsSelectorState<T>();
}

class _ItemsSelectorState<T> extends State<ItemsSelector<T>> {
  late List<T> _selectedItems;
  @override
  void initState() {
    _selectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final isSelected = _selectedItems.contains(item);
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
                          _selectedItems.add(item);
                        } else {
                          _selectedItems.remove(item);
                        }
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
                                _selectedItems.add(item);
                              } else {
                                _selectedItems.remove(item);
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.toText(item),
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
        ),
        const SizedBox(
          height: SpacesResources.s10,
        ),
        ElevatedButtonWidget(
          onPressed: () {
            widget.onSelect(_selectedItems);
            Navigator.of(context).pop();
          },
          title: 'اختيار ${_selectedItems.length} عنصر',
        ),
        TextButtonWidget(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: 'الغاء',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
