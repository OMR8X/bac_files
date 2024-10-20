import 'dart:io';

import 'package:bac_files_admin/core/services/api/api_manager.dart';
import 'package:bac_files_admin/core/services/cache/cache_client.dart';
import 'package:bac_files_admin/core/services/cache/cache_manager.dart';
import 'package:bac_files_admin/features/files/data/datasources/files_remote_datasource.dart';
import 'package:bac_files_admin/features/uploads/data/datasources/operations_local_datasource.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/operation_state.dart';
import 'package:bac_files_admin/features/uploads/domain/entities/upload_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mockers/mock_path_provider.dart';

class MockApiManager extends Mock implements ApiManager {}

// class MockApiManager extends Mock implements ApiManager {}

void main() async {
  //
  late UploadOperation operation;
  late List<UploadOperation> operations;
  late CacheClient cacheClient;
  late CacheManager cacheManager;
  late FilesRemoteDataSource filesRemoteDataSource;
  late OperationsLocalDataSource operationsLocalDataSource;
  late File fakeFile;

  setUpAll(() async {
    /// Ensure widgets are initialized
    TestWidgetsFlutterBinding.ensureInitialized();

    /// Initialize mock for path provider
    mockPathProviderPlatform();

    /// Set up other dependencies
    cacheClient = HiveClient();

    /// Set up the cache manager
    cacheManager = CacheManager(cacheClient);

    /// Initialize the cache manager
    await cacheManager.init();

    ///
    operationsLocalDataSource = OperationsLocalDataSourceImplement(cacheManager: cacheManager);

    ///
    filesRemoteDataSource = FilesRemoteDataSourceImplements(manager: ApiManager());
  });
}
