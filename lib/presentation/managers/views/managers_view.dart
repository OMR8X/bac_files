import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/core/resources/styles/padding_resources.dart';
import 'package:bac_files_admin/core/services/router/app_arguments.dart';
import 'package:bac_files_admin/core/widgets/dialogs/conform_dialog.dart';
import 'package:bac_files_admin/core/widgets/dialogs/delete_item_dialog.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_category.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_material.dart';
import 'package:bac_files_admin/features/managers/domain/entities/file_section.dart';
import 'package:bac_files_admin/features/managers/domain/entities/managers.dart';
import 'package:bac_files_admin/features/managers/domain/entities/school.dart';
import 'package:bac_files_admin/features/managers/domain/entities/teacher.dart';
import 'package:bac_files_admin/features/managers/domain/requests/delete_entity_request.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/delete_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/materials/delete_material_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/schools/delete_school_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/sections/delete_section_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/teachers/delete_teacher_usecase.dart';
import 'package:bac_files_admin/presentation/managers/state/managers_view/managers_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/styles/assets_resources.dart';
import '../../../core/services/router/app_routes.dart';
import '../widgets/category_tile_widget.dart';

class ManagersView extends StatefulWidget {
  const ManagersView({super.key});

  @override
  State<ManagersView> createState() => _ManagersViewState();
}

class _ManagersViewState extends State<ManagersView> {
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("التصانيف"),
      ),
      body: BlocProvider(
        create: (context) => sl<ManagersViewBloc>(),
        child: BlocBuilder<ManagersViewBloc, ManagersViewState>(
          builder: (context, state) {
            ///
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            ///
            return GridView(
              padding: PaddingResources.padding_2_2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 2,
              ),
              children: [
                CategoryTileWidget(
                  title: "اساتذة",
                  subTitle: sl<FileManagers>().teachers.length.toString(),
                  icon: UIImagesResources.teachersIcon,
                  onTap: () {
                    context.push(
                      AppRoutes.manager.path,
                      extra: ExploreManagerViewArguments(
                        title: "تصفح الاساتذة",
                        items: sl<FileManagers>().teachers,
                        itemName: (teacher) {
                          return teacher.name;
                        },
                        itemDetails: (teacher) {
                          return "الرقم : ${teacher.id}";
                        },
                        onDelete: (index) {
                          final teacher = sl<FileManagers>().teachers[index];
                          onDeleteTeacher(teacher);
                        },
                        onEdit: (index) {
                          final extra = sl<FileManagers>().teachers[index];
                          context.pushReplacement(AppRoutes.setUpTeacher.path, extra: extra);
                        },
                        onCreate: () {
                          context.pushReplacement(AppRoutes.setUpTeacher.path);
                        },
                      ),
                    );
                  },
                ),
                CategoryTileWidget(
                  title: "تصانيف",
                  subTitle: sl<FileManagers>().categories.length.toString(),
                  icon: UIImagesResources.categoriesIcon,
                  onTap: () {
                    context.push(
                      AppRoutes.manager.path,
                      extra: ExploreManagerViewArguments(
                        title: "تصفح التصانيف",
                        items: sl<FileManagers>().categories,
                        itemName: (category) {
                          return category.name;
                        },
                        itemDetails: (category) {
                          return "الرقم : ${category.id}";
                        },
                        onDelete: (index) {
                          final category = sl<FileManagers>().categories[index];
                          onDeleteCategory(category);
                        },
                        onEdit: (index) {
                          final extra = sl<FileManagers>().categories[index];
                          context.pushReplacement(AppRoutes.setUpCategory.path, extra: extra);
                        },
                        onCreate: () {
                          context.pushReplacement(AppRoutes.setUpCategory.path);
                        },
                      ),
                    );
                  },
                ),
                CategoryTileWidget(
                  title: "مواد",
                  subTitle: sl<FileManagers>().materials.length.toString(),
                  icon: UIImagesResources.materialsIcon,
                  onTap: () {
                    context.push(
                      AppRoutes.manager.path,
                      extra: ExploreManagerViewArguments(
                        title: "تصفح المواد",
                        items: sl<FileManagers>().materials,
                        itemName: (material) {
                          return material.name;
                        },
                        itemDetails: (material) {
                          return "الرقم : ${material.id}";
                        },
                        onDelete: (index) {
                          final material = sl<FileManagers>().materials[index];
                          onDeleteMaterial(material);
                        },
                        onEdit: (index) {
                          final extra = sl<FileManagers>().materials[index];
                          context.pushReplacement(AppRoutes.setUpMaterial.path, extra: extra);
                        },
                        onCreate: () {
                          context.pushReplacement(AppRoutes.setUpMaterial.path);
                        },
                      ),
                    );
                  },
                ),
                CategoryTileWidget(
                  title: "فروع",
                  subTitle: sl<FileManagers>().sections.length.toString(),
                  icon: UIImagesResources.sectionsIcon,
                  onTap: () {
                    context.push(
                      AppRoutes.manager.path,
                      extra: ExploreManagerViewArguments(
                        title: "تصفح الفروع",
                        items: sl<FileManagers>().sections,
                        itemName: (section) {
                          return section.name;
                        },
                        itemDetails: (section) {
                          return "الرقم : ${section.id}";
                        },
                        onDelete: (index) {
                          final section = sl<FileManagers>().sections[index];
                          onDeleteSection(section);
                        },
                        onEdit: (index) {
                          final extra = sl<FileManagers>().sections[index];
                          context.pushReplacement(AppRoutes.setUpSection.path, extra: extra);
                        },
                        onCreate: () {
                          context.pushReplacement(AppRoutes.setUpSection.path);
                        },
                      ),
                    );
                  },
                ),
                CategoryTileWidget(
                  title: "مدارس",
                  subTitle: sl<FileManagers>().schools.length.toString(),
                  icon: UIImagesResources.schoolsIcon,
                  onTap: () {
                    context.push(
                      AppRoutes.manager.path,
                      extra: ExploreManagerViewArguments(
                        title: "تصفح المدارس",
                        items: sl<FileManagers>().schools,
                        itemName: (school) {
                          return school.name;
                        },
                        itemDetails: (school) {
                          return "الرقم : ${school.id}";
                        },
                        onDelete: (index) {
                          final school = sl<FileManagers>().schools[index];
                          onDeleteSchool(school);
                        },
                        onEdit: (index) {
                          final extra = sl<FileManagers>().schools[index];
                          context.pushReplacement(AppRoutes.setUpSchool.path, extra: extra);
                        },
                        onCreate: () {
                          context.pushReplacement(AppRoutes.setUpSchool.path);
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  onDeleteTeacher(FileTeacher teacher) {
    showDeleteItemDialog(
      context: context,
      onConform: () {
        sl<ManagersViewBloc>().add(
          ManagersViewDeleteItemEvent(
            usecase: sl<DeleteTeacherUseCase>().call(
              request: DeleteEntityRequest(
                id: teacher.id,
              ),
            ),
          ),
        );
        context.pop();
      },
      item: teacher.name,
    );
  }

  onDeleteCategory(FileCategory category) {
    showDeleteItemDialog(
      context: context,
      onConform: () {
        sl<ManagersViewBloc>().add(
          ManagersViewDeleteItemEvent(
            usecase: sl<DeleteCategoryUseCase>().call(
              request: DeleteEntityRequest(
                id: category.id,
              ),
            ),
          ),
        );
        context.pop();
      },
      item: category.name,
    );
  }

  onDeleteMaterial(FileMaterial material) {
    showDeleteItemDialog(
      context: context,
      onConform: () {
        sl<ManagersViewBloc>().add(
          ManagersViewDeleteItemEvent(
            usecase: sl<DeleteMaterialUseCase>().call(
              request: DeleteEntityRequest(
                id: material.id,
              ),
            ),
          ),
        );
        context.pop();
      },
      item: material.name,
    );
  }

  onDeleteSection(FileSection section) {
    showDeleteItemDialog(
      context: context,
      onConform: () {
        sl<ManagersViewBloc>().add(
          ManagersViewDeleteItemEvent(
            usecase: sl<DeleteSectionUseCase>().call(
              request: DeleteEntityRequest(
                id: section.id,
              ),
            ),
          ),
        );
        context.pop();
      },
      item: section.name,
    );
  }

  onDeleteSchool(FileSchool school) {
    showDeleteItemDialog(
      context: context,
      onConform: () {
        sl<ManagersViewBloc>().add(
          ManagersViewDeleteItemEvent(
            usecase: sl<DeleteSchoolUseCase>().call(
              request: DeleteEntityRequest(
                id: school.id,
              ),
            ),
          ),
        );
        context.pop();
      },
      item: school.name,
    );
  }
}
