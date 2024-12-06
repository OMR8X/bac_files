import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cache_constant.dart';

abstract class CacheClient {
  /// initiate client
  Future<void> init(Directory appDir);

  /// initiate client
  Future<void> refresh(Directory appDir);

  /// check if key exist in cache
  Future<bool> exist(String key);

  /// write to cache
  Future<void> write(String key, dynamic data);

  /// read from cache
  Future<dynamic> read(String key);

  /// read all values from cache
  Future<dynamic> values();

  /// clear data of the passed key from cache
  Future<void> remove(String key);

  /// clear all data in cache
  Future<void> clear();
  //
  Future<void> close();
}

class HiveClient implements CacheClient {
  Box? _cacheBox;

  /// initiate hive box
  @override
  Future<void> init(Directory appDir) async {
    await Hive.initFlutter(appDir.path + CacheConstant.cacheSubDir);
    _cacheBox = await Hive.openBox(CacheConstant.boxName);
    return;
  }

  @override
  Future<void> refresh(Directory appDir) async {
    await close();
    await init(appDir);
    return;
  }

  /// check if key exist in cache
  @override
  Future<bool> exist(String key) async {
    return (_cacheBox ?? await Hive.openBox(CacheConstant.boxName)).containsKey(key);
  }

  /// write to hive box
  @override
  Future<void> write(String key, dynamic data) async {
    try {
      await (_cacheBox ?? await Hive.openBox(CacheConstant.boxName)).put(key, data);
    } on HiveError catch (_) {
      return;
    }
  }

  /// read from hive box
  @override
  Future<dynamic> read(String key) async {
    final data = await (_cacheBox ?? await Hive.openBox(CacheConstant.boxName)).get(key);
    return data;
  }

  /// read all values from hive box
  @override
  Future<dynamic> values() async {
    final data = (_cacheBox ?? await Hive.openBox(CacheConstant.boxName)).values.toList();
    return data;
  }

  /// clear data of the passed key from hive box
  @override
  Future<void> remove(String key) async {
    await (_cacheBox ?? await Hive.openBox(CacheConstant.boxName)).delete(key);
  }

  /// clear all data
  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  @override
  Future<void> close() async {
    try {
      await Hive.close();
    } on Exception catch (e) {
      _cacheBox = await Hive.openBox(CacheConstant.boxName);
    }
  }
}
