import 'package:bac_files_admin/core/resources/styles/border_radius_resources.dart';
import 'package:bac_files_admin/core/resources/styles/decoration_resources.dart';
import 'package:bac_files_admin/core/resources/styles/font_styles_manager.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/resources/styles/sizes_resources.dart';
import 'package:bac_files_admin/core/resources/styles/spaces_resources.dart';
import 'package:bac_files_admin/core/services/router/app_arguments.dart';
import 'package:bac_files_admin/core/widgets/animations/staggered_list_wrapper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExploreManagerView extends StatelessWidget {
  const ExploreManagerView({
    super.key,
    required this.arguments,
  });
  final ExploreManagerViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: SpacesResources.s80),
          itemCount: arguments.items.length,
          itemBuilder: (context, index) {
            //
            final item = arguments.items[index];
            //
            return StaggeredListWrapperWidget(
              position: index,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: SizesResources.mainWidth(context),
                    margin: PaddingResources.padding_2_2,
                    decoration: DecorationResources.tileDecoration(theme: Theme.of(context)),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadiusResource.tileBorderRadius,
                      child: InkWell(
                        onTap: () {
                          arguments.onEdit(index);
                        },
                        borderRadius: BorderRadiusResource.tileBorderRadius,
                        child: Padding(
                          padding: PaddingResources.padding_5_3,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      arguments.itemName(item),
                                      style: FontStylesResources.tileTitleStyle(context),
                                    ),
                                    const SizedBox(
                                      height: SpacesResources.s2,
                                    ),
                                    Text(
                                      arguments.itemDetails(item),
                                      style: FontStylesResources.tileSubTitleStyle(context),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton.filled(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                    onPressed: () {
                                      arguments.onEdit(index);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  IconButton.filled(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.onError,
                                    ),
                                    onPressed: () {
                                      arguments.onDelete(index);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: arguments.onCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}
