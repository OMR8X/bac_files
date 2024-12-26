import 'package:bac_files_admin/features/auth/domain/entites/user_data.dart';
import 'package:flutter/material.dart';

import '../../../features/files/domain/entities/bac_file.dart';

class ExploreManagerViewArguments {
  final String title;
  final List<dynamic> items;
  final String Function(dynamic t) itemName;
  final String Function(dynamic t) itemDetails;
  final void Function(int index) onDelete;
  final void Function(int index) onEdit;
  final VoidCallback onCreate;

  const ExploreManagerViewArguments({
    required this.title,
    required this.items,
    required this.itemName,
    required this.itemDetails,
    required this.onDelete,
    required this.onEdit,
    required this.onCreate,
  });
}

class SetUpFileArguments {
  final bool isLoading, isUpdating;
  final String? path;
  final BacFile? bacFile;
  final void Function(BacFile file, String path) onSubmit;
  final void Function(String path)? onChangeFilePath;

  SetUpFileArguments({
    this.isLoading = false,
    this.isUpdating = false,
    this.path,
    this.bacFile,
    required this.onSubmit,
    this.onChangeFilePath,
  });
}

