import 'package:bac_files/core/services/router/app_transations.dart';
import 'package:bac_files/features/files/domain/entities/bac_file.dart';
import 'package:bac_files/presentation/auth/view/auth_start_view.dart';
import 'package:bac_files/presentation/auth/view/auth_views_manager.dart';
import 'package:bac_files/presentation/auth/view/update_user_data_view.dart';
import 'package:bac_files/presentation/auth/view/sign_in_view.dart';
import 'package:bac_files/presentation/auth/view/sign_up_view.dart';
import 'package:bac_files/presentation/debugging/views/debugs_view.dart';
import 'package:bac_files/presentation/files/views/create_file_view.dart';
import 'package:bac_files/presentation/files/views/explore_file_view.dart';
import 'package:bac_files/presentation/files/views/pdf_bac_file_view.dart';
import 'package:bac_files/presentation/files/views/pdf_file_view.dart';
import 'package:bac_files/presentation/files/views/update_file_view.dart';
import 'package:bac_files/presentation/files/views/update_operation_file_view.dart';
import 'package:bac_files/presentation/managers/views/exaplore_manager_view.dart';
import 'package:bac_files/presentation/managers/views/managers_view.dart';
import 'package:bac_files/presentation/home/views/home_view.dart';
import 'package:bac_files/presentation/managers/views/setters/set_up_categorie_view.dart';
import 'package:bac_files/presentation/managers/views/setters/set_up_material_view.dart';
import 'package:bac_files/presentation/managers/views/setters/set_up_school_view.dart';
import 'package:bac_files/presentation/managers/views/setters/set_up_section_view.dart';
import 'package:bac_files/presentation/managers/views/setters/set_up_teacher_view.dart';
import 'package:bac_files/presentation/root/views/app_loader_view.dart';
import 'package:bac_files/presentation/root/views/pages_holder.dart';
import 'package:bac_files/presentation/settings/views/settings_view.dart';
import 'package:bac_files/presentation/uploads/views/uploads_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../features/managers/domain/entities/file_category.dart';
import '../../../features/managers/domain/entities/file_material.dart';
import '../../../features/managers/domain/entities/file_section.dart';
import '../../../features/managers/domain/entities/school.dart';
import '../../../features/managers/domain/entities/teacher.dart';
import '../../../presentation/downloads/views/downloads_view.dart';
import 'app_arguments.dart';
import 'app_routes.dart';

class AppRouter {
  ///
  /// keys for the root navigator
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorUploads = GlobalKey<NavigatorState>();
  static final _rootNavigatorDownloads = GlobalKey<NavigatorState>();
  static final _rootNavigatorCategories = GlobalKey<NavigatorState>();

  ///
  ///
  static final router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: AppRoutes.authViewsManager.path,
    navigatorKey: _rootNavigatorKey,
    routes: [
      // loader route
      GoRoute(
        name: AppRoutes.loader.name,
        path: AppRoutes.loader.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: AppLoaderView(
            key: state.pageKey,
          ),
        ),
      ),
      // manager route
      GoRoute(
        name: AppRoutes.manager.name,
        path: AppRoutes.manager.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: ExploreManagerView(
            arguments: state.extra as ExploreManagerViewArguments,
          ),
        ),
      ),
      // auth views manager route
      GoRoute(
        name: AppRoutes.authViewsManager.name,
        path: AppRoutes.authViewsManager.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const AuthViewsManager(),
        ),
      ),
      // auth start route
      GoRoute(
        name: AppRoutes.authStart.name,
        path: AppRoutes.authStart.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const AuthStartView(),
        ),
      ),

      // settings route
      GoRoute(
        name: AppRoutes.settings.name,
        path: AppRoutes.settings.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const SettingsView(),
        ),
      ),

      // set up user data route
      GoRoute(
        name: AppRoutes.updateUserData.name,
        path: AppRoutes.updateUserData.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const UpdateUserDataView(),
        ),
      ),
      // setUpTeacher route
      GoRoute(
        name: AppRoutes.setUpTeacher.name,
        path: AppRoutes.setUpTeacher.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: SetUpTeacherView(
            teacher: state.extra as FileTeacher?,
          ),
        ),
      ),
      // setUpCategory route
      GoRoute(
        name: AppRoutes.setUpCategory.name,
        path: AppRoutes.setUpCategory.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: SetUpCategoryView(
            category: state.extra as FileCategory?,
          ),
        ),
      ),
      // setUpMaterial route
      GoRoute(
        name: AppRoutes.setUpMaterial.name,
        path: AppRoutes.setUpMaterial.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: SetUpMaterialView(
            material: state.extra as FileMaterial?,
          ),
        ),
      ),
      // setUpSection route
      GoRoute(
        name: AppRoutes.setUpSection.name,
        path: AppRoutes.setUpSection.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: SetUpSectionView(
            section: state.extra as FileSection?,
          ),
        ),
      ),
      // setUpSchool route
      GoRoute(
        name: AppRoutes.setUpSchool.name,
        path: AppRoutes.setUpSchool.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: SetUpSchoolView(
            school: state.extra as FileSchool?,
          ),
        ),
      ),
      // createFile route
      GoRoute(
        name: AppRoutes.createFile.name,
        path: AppRoutes.createFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const CreateFileView(),
        ),
      ),
      // updateFile route
      GoRoute(
        name: AppRoutes.updateFile.name,
        path: AppRoutes.updateFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: UpdateFileView(
            fileId: state.extra as String,
          ),
        ),
      ),
      // explore route
      GoRoute(
        name: AppRoutes.exploreFile.name,
        path: AppRoutes.exploreFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: ExploreFileView(
            fileId: state.extra as String,
          ),
        ),
      ),
      // pdf file route
      GoRoute(
        name: AppRoutes.remotePdfFile.name,
        path: AppRoutes.remotePdfFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          opaque: false,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: PdfBacFileView(
            file: state.extra as BacFile,
          ),
        ),
      ),
      // pdf file route
      GoRoute(
        name: AppRoutes.localPdfFile.name,
        path: AppRoutes.localPdfFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          opaque: false,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: PdfFileView(
            path: state.extra as String,
          ),
        ),
      ),
      // updateOperationFile route
      GoRoute(
        name: AppRoutes.updateOperationFile.name,
        path: AppRoutes.updateOperationFile.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: UpdateOperationFileView(
            operationId: state.extra as int,
          ),
        ),
      ),
      // debugs route
      GoRoute(
        name: AppRoutes.debugs.name,
        path: AppRoutes.debugs.path,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: AppTransitions.transitionDuration,
          reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
          },
          child: const DebugsView(),
        ),
      ),

      /// pages holder route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return PagesHolderView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              ///
              /// Home route
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: AppTransitions.transitionDuration,
                  reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                  },
                  child: HomeView(
                    key: state.pageKey,
                  ),
                ),
              ),
            ],
          ),

          ///
          /// Uploads route
          StatefulShellBranch(
            navigatorKey: _rootNavigatorUploads,
            routes: [
              GoRoute(
                name: AppRoutes.uploads.name,
                path: AppRoutes.uploads.path,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: AppTransitions.transitionDuration,
                  reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                  },
                  child: UploadsView(
                    key: state.pageKey,
                  ),
                ),
              ),
            ],
          ),

          /// Downloads route
          StatefulShellBranch(
            navigatorKey: _rootNavigatorDownloads,
            routes: [
              GoRoute(
                name: AppRoutes.downloads.name,
                path: AppRoutes.downloads.path,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: AppTransitions.transitionDuration,
                  reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                  },
                  child: DownloadsView(
                    key: state.pageKey,
                  ),
                ),
              ),
            ],
          ),

          ///
          /// Categories route
          StatefulShellBranch(
            navigatorKey: _rootNavigatorCategories,
            routes: [
              GoRoute(
                name: AppRoutes.managers.name,
                path: AppRoutes.managers.path,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  transitionDuration: AppTransitions.transitionDuration,
                  reverseTransitionDuration: AppTransitions.reverseTransitionDuration,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return AppTransitions.commonTransition(context, animation, secondaryAnimation, child);
                  },
                  child: ManagersView(
                    key: state.pageKey,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    ],
  );
}
