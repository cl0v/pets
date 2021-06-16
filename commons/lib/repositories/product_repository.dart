import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/repositories/store_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../commons.dart';

class ProductFirebase {
  static final String collectionPath = 'products';

  final CollectionReference<Product> ref = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromSnap(snapshot),
        toFirestore: (model, _) => model.toMap(),
      );

  create(PlatformFile file, Product p) async => ref.add(p).then((r) =>
      FirestoreImageUploader(product: p).uploadFoto(r, file, Product.pImgUrl));

  Stream<List<Product>> readAll() =>
      ref.snapshots().map((p) => p.docs.map((e) => e.data()).toList());

  Stream<List<Product>> readFromStore(String storeId) => ref
      .where(Product.pStoreId, isEqualTo: storeId)
      .snapshots()
      .map((p) => p.docs.map((e) => e.data()).toList());

  update(Product p) => ref.doc(p.id).update(p.toMap());

  delete(String id) => ref.doc(id).delete();
  //TODO: Remover a imagem do storage tambem bro
}

class FirestoreImageUploader {
  FirestoreImageUploader({required this.product});
  Product product;

  uploadFoto(
    DocumentReference docRef,
    PlatformFile file,
    String field,
  ) async {
    var ref = FirebaseStorage.instance
        .ref()
        .child(StoreFirebase.collectionPath)
        .child(product.storeId)
        .child('products')
        .child(docRef.id)
        .child(file.name);

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    if (kIsWeb) {
      await ref.putData(file.bytes!, metadata).whenComplete(() async {
        await docRef.update({field: await ref.getDownloadURL()});
      });
    } else {
      await ref.putFile(File(file.path!), metadata).whenComplete(
          () async => await docRef.update({field: await ref.getDownloadURL()}));
    }
  }
}
