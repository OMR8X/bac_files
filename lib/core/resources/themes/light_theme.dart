import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/resources/styles/colors_resources.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:flutter/material.dart';

import '../styles/sizes_resources.dart';
import 'extensions/success_colors.dart';

class AppLightTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      fontFamily: "Vazirmatn",
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorsResourcesLight.primary,
        onPrimary: ColorsResourcesLight.onPrimary,
        secondary: ColorsResourcesLight.primary,
        onSecondary: ColorsResourcesLight.primary,
        error: ColorsResourcesLight.error,
        onError: ColorsResourcesLight.onError,
        //
        surface: ColorsResourcesLight.surface,
        onSurface: ColorsResourcesLight.onSurface,
        onSurfaceVariant: ColorsResourcesLight.onSurfaceVariant,
        //
        outline: ColorsResourcesLight.outline,
        outlineVariant: ColorsResourcesLight.outlineVariant,
        //
        shadow: ColorsResourcesLight.lightShadow,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SurfaceContainerColors(
          surfaceContainer: ColorsResourcesLight.surfaceContainer,
          surfaceContainerHigh: ColorsResourcesLight.surfaceContainerHigh,
        ),
        SuccessColors(
          success: ColorsResourcesLight.success,
          onSuccess: ColorsResourcesLight.onSuccess,
        ),
      ],

      ///
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          fill: 1,
          color: ColorsResourcesLight.onSurfaceVariant,
          opticalSize: 1,
        ),
      ),

      ///
      dialogTheme: DialogTheme(
        backgroundColor: ColorsResourcesLight.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusResource.dialogBorderRadius,
        ),
      ),

      ///
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadiusResource.fieldBorderRadius,
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          contentPadding: PaddingResources.padding_3_1,
        ),
      ),

      ///
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: const WidgetStatePropertyAll(
            ColorsResourcesLight.surfaceContainer,
          ),
          alignment: Alignment.topCenter,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusResource.fieldBorderRadius,
            ),
          ),
        ),
      ),

      ///
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledBackgroundColor: ColorsResourcesLight.onSurfaceVariant,
          shadowColor: Colors.transparent,
          backgroundColor: ColorsResourcesLight.primary,
          foregroundColor: ColorsResourcesLight.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusResource.buttonBorderRadius,
          ),
        ),
      ),

      ///
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          iconSize: 15,
          minimumSize: const Size(20, 20),
        ),
      ),

      ///
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadiusResource.fieldBorderRadius,
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        contentPadding: PaddingResources.padding_3_1,
      ),
    );
  }
}
