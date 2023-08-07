abstract interface class DBProvider<T> {
  get(String key);
  Map<dynamic, dynamic> getAll();
  Future<void> add(Object obj);
  Future<void> put(String key, Object obj);
  Future<void> putAt(int index, Object obj);
  Future<void> deleteAt(int key);
  Future<void> delete(dynamic key);
  bool isNotEmpty();
}
