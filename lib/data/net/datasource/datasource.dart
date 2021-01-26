
/// Describes abstract functionality
abstract class DataSource<T> {
  /// Fetches all data in realtime
  Stream<List<T>> allItemsStream();
  /// Adds single item
  Future<void> addItems(T product);
  /// Removes single item 
  Future<void> removeItem(T product);
}
