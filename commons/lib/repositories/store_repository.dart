import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/models/store.dart';

class StoreFirebase {
  //TODO: Renomear para 'store'

  static final String collectionPath = 'stores';

  final ref = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<Store>(
        fromFirestore: (snapshot, _) => Store.fromSnap(snapshot),
        toFirestore: (model, _) => model.toMap(),
      );

  Future<DocumentReference<Store>> create(Store s) => ref.add(s);

  Stream<Store?> read(String id) =>
      ref.where(Store.pUserId, isEqualTo: id).snapshots().map(
            (s) => s.docs.first.data(),
          );

//Precisa ser stream? nao, pode ser future, mas stream eh sempre melhor pelo padrao bloc
  Stream<List<Store>> readAll() =>
      ref.snapshots().map((s) => s.docs.map((e) => e.data()).toList());

  update(Store s) => ref.doc(s.id).update(s.toMap());

  delete(String id) => ref.doc(id).delete();
}
