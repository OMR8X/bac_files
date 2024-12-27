import 'package:bac_files/core/resources/styles/spaces_resources.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../resources/styles/sizes_resources.dart';

class FileAttachmentWidget extends StatelessWidget {
  const FileAttachmentWidget({
    super.key,
    required this.filePath,
    required this.afterPick,
  });
  final String? filePath;
  final void Function({PlatformFile? file}) afterPick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: SizesResources.mainWidth(context),
        child: DottedBorder(
          color: Theme.of(context).colorScheme.outline,
          strokeWidth: 3,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          dashPattern: const [8, 8],
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: SpacesResources.s20),
                Text(
                  filePath?.split("/").last ?? "لم يتم اختيار ملف",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                //
                const SizedBox(height: SpacesResources.s2),
                //
                TextButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      afterPick(file: result.files.first);
                    }
                  },
                  child: Text(
                    filePath != null ? 'ملف جديد' : "اختيار ملف",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: SpacesResources.s8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
