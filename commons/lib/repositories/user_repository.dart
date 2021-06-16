import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/models/user_model.dart';

class UserRepository {
  static final String collectionPath = 'users';

  final CollectionReference<UserModel> ref = FirebaseFirestore.instance
      .collection(collectionPath)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromSnap(snapshot),
        toFirestore: (model, _) => model.toMap(),
      );

  Future<UserModel> read(String uid) => ref
      .where(UserModel.pUid, isEqualTo: uid)
      .snapshots()
      .first
      .then((value) => value.docs.first.data());
}
