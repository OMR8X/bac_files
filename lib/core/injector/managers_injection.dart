import 'package:bac_files_admin/core/injector/app_injection.dart';
import 'package:bac_files_admin/features/managers/data/datasources/managers_remote_datasource.dart';
import 'package:bac_files_admin/features/managers/data/repositories/managers_remote_datasource_implement.dart';
import 'package:bac_files_admin/features/managers/domain/repositories/managers_repository.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/create_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/delete_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/select_categories_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/categories/update_category_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/materials/delete_material_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/materials/select_materials_usecase.dart';
import 'package:bac_files_admin/features/managers/domain/usecases/materials/update_material_usecase.dart';

import '../../features/managers/domain/usecases/select_managers_usecase.dart';
import '../../features/managers/domain/usecases/materials/create_material_usecase.dart';
import '../../features/managers/domain/usecases/schools/create_school_usecase.dart';
import '../../features/managers/domain/usecases/schools/delete_school_usecase.dart';
import '../../features/managers/domain/usecases/schools/select_schools_usecase.dart';
import '../../features/managers/domain/usecases/schools/update_school_usecase.dart';
import '../../features/managers/domain/usecases/sections/create_section_usecase.dart';
import '../../features/managers/domain/usecases/sections/delete_section_usecase.dart';
import '../../features/managers/domain/usecases/sections/select_sections_usecase.dart';
import '../../features/managers/domain/usecases/sections/update_section_usecase.dart';
import '../../features/managers/domain/usecases/teachers/create_teacher_usecase.dart';
import '../../features/managers/domain/usecases/teachers/delete_teacher_usecase.dart';
import '../../features/managers/domain/usecases/teachers/select_teachers_usecase.dart';
import '../../features/managers/domain/usecases/teachers/update_teacher_usecase.dart';

managersInjection() {
  ///
  /// [ Data Sources ]
  sl.registerFactory<ManagersRemoteDataSource>(
    () => ManagersRemoteDataSourceImplement(
      apiManager: sl(),
    ),
  );

  ///
  /// [ Repositories ]
  sl.registerFactory<ManagersRepository>(
    () => ManagersRepositoryImplement(
      remoteDataSource: sl(),
    ),
  );

  ///
  /// [Use Cases]
  ///
  /// [Managers]
  sl.registerFactory<SelectManagersUseCase>(
    () => SelectManagersUseCase(
      repository: sl(),
    ),
  );

  ///
  /// [Categories]
  sl.registerFactory<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<SelectCategoriesUseCase>(
    () => SelectCategoriesUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteCategoryUseCase>(
    () => DeleteCategoryUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateCategoryUseCase>(
    () => UpdateCategoryUseCase(
      repository: sl(),
    ),
  );

  ///
  /// [Materials]
  sl.registerFactory<CreateMaterialUseCase>(
    () => CreateMaterialUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<SelectMaterialsUseCase>(
    () => SelectMaterialsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteMaterialUseCase>(
    () => DeleteMaterialUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateMaterialUseCase>(
    () => UpdateMaterialUseCase(
      repository: sl(),
    ),
  );

  ///
  /// [Schools]
  sl.registerFactory<CreateSchoolUseCase>(
    () => CreateSchoolUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<SelectSchoolsUseCase>(
    () => SelectSchoolsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteSchoolUseCase>(
    () => DeleteSchoolUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateSchoolUseCase>(
    () => UpdateSchoolUseCase(
      repository: sl(),
    ),
  );

  ///
  /// [Sections]
  sl.registerFactory<CreateSectionUseCase>(
    () => CreateSectionUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<SelectSectionsUseCase>(
    () => SelectSectionsUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteSectionUseCase>(
    () => DeleteSectionUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateSectionUseCase>(
    () => UpdateSectionUseCase(
      repository: sl(),
    ),
  );

  ///
  /// [Teachers]
  sl.registerFactory<CreateTeacherUseCase>(
    () => CreateTeacherUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<SelectTeachersUseCase>(
    () => SelectTeachersUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<DeleteTeacherUseCase>(
    () => DeleteTeacherUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory<UpdateTeacherUseCase>(
    () => UpdateTeacherUseCase(
      repository: sl(),
    ),
  );
}

