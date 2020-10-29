abstract class IssueLocal {
  Future<bool> saveListIssueByIds(List<String> issueIds);
  Future<List<String>> loadIssueFromLocal();
}