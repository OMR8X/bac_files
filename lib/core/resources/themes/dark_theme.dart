import 'package:bac_files_admin/core/resources/styles/colors_resources.dart';
import 'package:bac_files_admin/core/resources/themes/extensions/surface_container_colors.dart';
import 'package:flutter/material.dart';
import '../styles/border_radius_resources.dart';
import '../styles/padding_resources.dart';
import '../styles/sizes_resources.dart';
import 'extensions/success_colors.dart';

class AppDarkTheme {
  ///
  static ThemeData theme() {
    return ThemeData(
      fontFamily: "Vazirmatn",
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: ColorsResourcesDark.primary,
        onPrimary: ColorsResourcesDark.onPrimary,
        secondary: ColorsResourcesDark.primary,
        onSecondary: ColorsResourcesDark.primary,
        error: ColorsResourcesDark.error,
        onError: ColorsResourcesDark.onError,
        background: ColorsResourcesDark.surface,
        onBackground: ColorsResourcesDark.onSurface,
        surface: ColorsResourcesDark.surface,
        onSurface: ColorsResourcesDark.onSurface,
        onSurfaceVariant: ColorsResourcesDark.onSurfaceVariant,
        //
        outline: ColorsResourcesDark.outline,
        outlineVariant: ColorsResourcesDark.outlineVariant,
        //
        shadow: ColorsResourcesDark.lightShadow,
      ),

      extensions: <ThemeExtension<dynamic>>[
        SurfaceContainerColors(
          surfaceContainer: ColorsResourcesDark.surfaceContainer,
          surfaceContainerHigh: ColorsResourcesDark.surfaceContainerHigh,
        ),
                SuccessColors(
          success: ColorsResourcesDark.success,
          onSuccess: ColorsResourcesDark.onSuccess,
        ),
      ],
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
          backgroundColor: const MaterialStatePropertyAll(
            ColorsResourcesDark.surfaceContainerHigh,
          ),
          alignment: Alignment.topCenter,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusResource.fieldBorderRadius,
            ),
          ),
        ),
      ),

      ///
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          //
          backgroundColor: ColorsResourcesDark.primary,
          foregroundColor: ColorsResourcesDark.onPrimary,
          //
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
