class ApiSettings {
  //
  static const receiveTimeout = 60;
  static const sendTimeout = 60 * 60;
  static const connectTimeout = 15;
  //
  // static const baseUrl = 'http://127.0.0.1:8000';

  static const baseUrl = 'http://82.180.146.95';
  //
}

class ApiHeaders {
  ///
  /// [Keys]
  ///
  static const headerAuthorizationKey = 'authorization';
  static const headerContentTypeKey = 'content-type';
  static const headerAcceptKey = 'accept';
  static const headerApiKeys = 'api-key';

  ///
  /// [Values]
  ///
  static const headerAuthorizationBarer = 'barer';
  static const headerContentTypeJson = 'application/json';
}

class ApiEndpoints {
  ///
  /// [Auth]
  ///
  static String get signIn => '/api/auth/sign-in';
  static String get signUp => '/api/auth/sign-up';
  static String get signOut => '/api/auth/sign-out';
  static String get changePassword => '/api/auth/change-password';
  static String get forgetPassword => '/api/auth/forget-password';
  static String get getUserData => '/api/auth/get-user-data';
  static String get updateUserData => '/api/auth/update-user-data';

  ///
  /// [Managers]
  static String get managers => '/api/managers';

  ///
  ///  [sections]
  static String get sections => '$managers/sections';

  ///  [teachers]
  static String get teachers => '$managers/teachers';

  ///  [schools]
  static String get schools => '$managers/schools';

  ///  [materials]
  static String get materials => '$managers/materials';

  ///  [categories]
  static String get categories => '$managers/categories';

  ///  [files]
  static String get files => '/api/files';

  static String get search => '$files/search';

  ///
  static String viewPdf(String id) {
    return "${ApiSettings.baseUrl}/pdf-viewer/$id";
  }

  ///
  static String downloadFile(String id) {
    return "$files/download/$id";
  }
}
