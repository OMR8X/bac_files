import 'package:flutter/material.dart';

import '../../../resources/styles/sizes_resources.dart';

class CheckTitleWidget extends StatelessWidget {
  const CheckTitleWidget({
    super.key,
    required this.onChange,
    this.value = false,
  });
  final bool value;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: SizesResources.mainWidth(context),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {
                onChange(value ?? false);
              },
            ),
            const Text("keep me logged in"),
          ],
        ),
      ),
    );
  }
}
