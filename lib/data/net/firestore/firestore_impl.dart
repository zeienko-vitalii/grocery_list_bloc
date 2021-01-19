import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_tracker_app/data/net/datasource/datasource.dart';
import 'package:list_tracker_app/data/net/models/grocery_product.dart';

class FireStoreImpl extends DataSource<GroceryProduct> {
  final CollectionReference _groceries = FirebaseFirestore.instance.collection('groceries');

  @override
  Future<List<GroceryProduct>> fetchAllItems() {
    return _groceries.get().then((QuerySnapshot value) {
      return value?.docs
          ?.map(
            (QueryDocumentSnapshot e) => GroceryProduct.fromQueryDocumentSnapshot(e),
          )
          ?.toList();
    });
  }

  @override
  Stream<List<GroceryProduct>> allItems() {
    return _groceries.snapshots().map((QuerySnapshot event) {
      return event?.docs
          ?.map(
            (QueryDocumentSnapshot e) => GroceryProduct.fromQueryDocumentSnapshot(e),
          )
          ?.toList();
    });
  }

  @override
  Future<void> removeItem(GroceryProduct product) async {
    final DocumentReference ref = _groceries.doc(product?.id);
    await ref.delete();
  }

  @override
  Future<void> addItems(GroceryProduct product) async {
    final DocumentReference ref = await _groceries.add(product?.toJson());
    print(ref);
  }
}
