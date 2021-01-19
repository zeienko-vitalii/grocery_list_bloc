import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryProduct {
  const GroceryProduct({this.id, this.title, this.ms});

  GroceryProduct.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot)
      : id = snapshot?.id,
        title = snapshot?.data() == null ? null : snapshot?.data()['title'],
        ms = snapshot?.data() == null ? null : snapshot?.data()['ms_from_epoch'];
  final String title;
  final String id;
  final int ms;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'ms_from_epoch': DateTime.now().millisecondsSinceEpoch,
      };

  @override
  String toString() => 'GroceryProduct(title: $title, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroceryProduct && other.title == title && other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;

  static int sort(GroceryProduct obj1, GroceryProduct obj2) {
    if ((obj1?.ms ?? -1) < (obj2?.ms ?? -1)) {
      return -1;
    } else if ((obj1?.ms ?? -1) > (obj2?.ms ?? -1)) {
      return 1;
    } else {
      return 0;
    }
  }
}
