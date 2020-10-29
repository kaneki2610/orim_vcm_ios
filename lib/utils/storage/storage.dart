abstract class Storage {
  Future<bool> writeObject(String key, Map<String, dynamic> jsonObject);
  Future<Map<String, dynamic>> readObject(String key);

  Future<bool> writeList(String key, List list);
  Future<List> readList(String key);

  Future<bool> delete(String key);
}