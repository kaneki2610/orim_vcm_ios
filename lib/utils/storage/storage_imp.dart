import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orim/utils/storage/storage.dart';

class StorageImp implements Storage {

  final storage = FlutterSecureStorage();

  @override
  Future<Map<String, dynamic>> readObject(String key) async {
    try {
      String jsonEncode = await storage.read(key: key);
      return json.decode(jsonEncode) as Map<String, dynamic>;
    } catch (err) {
      print(err);
      return null;
    }
  }

  @override
  Future<bool> writeObject(String key, Map<String, dynamic> jsonObject) async {
    try {
      await storage.write(key: key, value: json.encode(jsonObject));
      return true;
    } catch (err) {
      print(err);
    }
    return false;
  }

  @override
  Future<bool> writeList(String key, List list) async {
    try {
      await storage.write(key: key, value: json.encode(list));
      return true;
    } catch (err) {
      print(err);
    }
    return false;
  }

  @override
  Future<List> readList(String key) async {
    try {
      String jsonEncode = await storage.read(key: key);
      return json.decode(jsonEncode) as List;
    } catch (err) {
      print(err);
      return null;
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

}