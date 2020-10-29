import 'package:flutter/cupertino.dart';
import 'package:orim/storage/issue/local/issue_local.dart';
import 'package:orim/utils/storage/storage.dart';

class IssueLocalImp implements IssueLocal {

  Storage storage;
  final String _keyStorage = 'issueIds';

  @override
  Future<List<String>> loadIssueFromLocal() async {
    try {
      List res = await storage.readList(_keyStorage);
      if (res == null) {
        return [];
      } else {
        return res.map((e) => e.toString()).toList();
      }
    } catch (err) {
      return [];
    }
  }

  @override
  Future<bool> saveListIssueByIds(List<String> issueIds) async {
    try {
      return await storage.writeList(_keyStorage, issueIds);
    } catch (err) {
      return false;
    }
  }

}