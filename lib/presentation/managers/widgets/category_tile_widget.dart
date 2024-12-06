import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/styles/decoration_resources.dart';
import '../../../core/resources/styles/padding_resources.dart';
import '../../../core/resources/styles/sizes_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';

class CategoryTileWidget extends StatelessWidget {
  const CategoryTileWidget({super.key, required this.icon, required this.onTap, required this.title, required this.subTitle});
  final String icon;
  final String title;
  final String subTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: SizesResources.mainHalfWidth(context),
      margin: PaddingResources.padding_2_2,
      decoration: DecorationResources.tileDecoration(
        theme: Theme.of(context),
        
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadiusResource.tileBorderRadius,
        child: InkWell(
          borderRadius: BorderRadiusResource.tileBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: PaddingResources.padding_4_2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 75 / 3,
                  backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
                  child: Image.asset(
                    icon,
                    width: 75 / 3,
                  ),
                ),
                const SizedBox(
                  width: SpacesResources.s4,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding: PaddingResources.padding_3_1,
                      margin: PaddingResources.padding_0_2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainerHigh,
                        borderRadius: BorderRadiusResource.bordersRadiusTiny,
                      ),
                      child: Text(
                        subTitle,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
