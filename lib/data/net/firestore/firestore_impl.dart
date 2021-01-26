import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_tracker_app/data/net/datasource/datasource.dart';
import 'package:list_tracker_app/data/net/models/grocery_product.dart';

/// Singleton class that implements [DataSource] interface using Firebase source
class FireStoreImpl extends DataSource<GroceryProduct> {
  factory FireStoreImpl() => _singleton;

  FireStoreImpl._();

  static final FireStoreImpl _singleton = FireStoreImpl._();
  final CollectionReference _groceriesCollectionReference = FirebaseFirestore.instance.collection('groceries');

  @override
  Stream<List<GroceryProduct>> allItemsStream() {
    return _groceriesCollectionReference.snapshots().map((QuerySnapshot event) {
      return event?.docs
          ?.map(
            (QueryDocumentSnapshot e) => GroceryProduct.fromQueryDocumentSnapshot(e),
          )
          ?.toList();
    });
  }

  @override
  Future<void> removeItem(GroceryProduct product) async {
    final DocumentReference ref = _groceriesCollectionReference.doc(product?.id);
    await ref.delete();
  }

  @override
  Future<void> addItems(GroceryProduct product) async {
    await _groceriesCollectionReference.add(product?.toJson());
  }
}
