
/// Describes abstract functionality
abstract class DataSource<T> {
  Future<List<T>> fetchAllItems();
  Stream<List<T>> allItems();
  Future<void> addItems(T product);
  Future<void> removeItem(T product);
}
