import 'package:commons/commons.dart';

class StoreRepository {
  StoreFirebase _firebase = StoreFirebase();

  Future<Store?> read(String userId) => _firebase.ref
          .where(Store.pUserId, isEqualTo: userId)
          .snapshots()
          .first
          .then((q) {
        if (q.docs.isNotEmpty)
          return q.docs.first.data();
      });

  create(s) => _firebase.create(s);
}
