
/// Describes abstract functionality
abstract class DataSource<T> {
  Stream<List<T>> allItemsStream();
  Future<void> addItems(T product);
  Future<void> removeItem(T product);
}
