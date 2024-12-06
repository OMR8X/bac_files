import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../resources/styles/border_radius_resources.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/padding_resources.dart';
import '../../../resources/styles/sizes_resources.dart';
import '../../../resources/themes/extensions/surface_container_colors.dart';

class DropDownWidget<T> extends StatefulWidget {
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
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  bool _isDropdownOpen = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isDropdownOpen = _focusNode.hasFocus;
    });
  }

  Future<bool> _onWillPop() async {
    if (_isDropdownOpen) {
      _focusNode.unfocus();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDropdownOpen,
      onPopInvokedWithResult: (didPop, result) {
        _onWillPop();
      },
      child: Row(
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
                focusNode: _focusNode,
                textStyle: FontStylesResources.buttonStyle,
                hintText: widget.hintText,
                label: widget.hintText != null ? Text(widget.hintText!) : null,
                width: SizesResources.mainWidth(context),
                initialSelection: widget.initialSelection,
                onSelected: (item) {
                  if (widget.onSelected != null) {
                    item != widget.initialSelection ? widget.onSelected!(item) : widget.onSelected!(null);
                  }
                },
                dropdownMenuEntries: widget.entries.map((e) {
                  return DropdownMenuEntry<T?>(
                    value: e,
                    label: widget.toLabel(e),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
