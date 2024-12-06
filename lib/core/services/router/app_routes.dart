/// Represents the app routes and their paths.
enum AppRoutes {
  loader(
    name: 'loader',
    path: '/loader',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  uploads(
    name: 'uploads',
    path: '/uploads',
  ),
  downloads(
    name: 'downloads',
    path: '/downloads',
  ),
  manager(
    name: 'manager',
    path: '/manager',
  ),
  managers(
    name: 'managers',
    path: '/managers',
  ),
  setUpTeacher(
    name: 'set-up-teacher',
    path: '/set-up-teacher',
  ),
  setUpCategory(
    name: 'set-up-category',
    path: '/set-up-category',
  ),
  setUpMaterial(
    name: 'set-up-material',
    path: '/set-up-material',
  ),
  setUpSection(
    name: 'set-up-section',
    path: '/set-up-section',
  ),
  setUpSchool(
    name: 'set-up-school',
    path: '/set-up-school',
  ),
  createFile(
    name: 'create-file',
    path: '/create-file',
  ),
  updateFile(
    name: 'update-file',
    path: '/update-file',
  ),
  exploreFile(
    name: 'explore-file',
    path: '/explore-file',
  ),
  remotePdfFile(
    name: 'remote-pdf-file',
    path: '/remote-pdf-file',
  ),
  localPdfFile(
    name: 'local-pdf-file',
    path: '/local-pdf-file',
  ),
  updateOperationFile(
    name: 'update-operation-file',
    path: '/update-operation-file',
  ),
  debugs(
    name: 'debugs',
    path: '/debugs',
  ),
  testing(
    name: 'testing',
    path: '/testing',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.home.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.home.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
