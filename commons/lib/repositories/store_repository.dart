import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/models/store.dart';

class StoreFirebase {
  static final String collectionPath = 'stores';

  final ref = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<Store>(
        fromFirestore: (snapshot, _) => Store.fromSnap(snapshot),
        toFirestore: (model, _) => model.toMap(),
      );

  Future<DocumentReference<Store>> create(Store s) => ref.add(s);

  Future<Store?> read(String id) async {
    final b = await ref.doc(id).snapshots().first;
    return b.data();
  }

  Stream<List<Store>> readAll() =>
      ref.snapshots().map((s) => s.docs.map((e) => e.data()).toList());

  update(Store s) => ref.doc(s.id).update(s.toMap());

  delete(String id) => ref.doc(id).delete();
}
