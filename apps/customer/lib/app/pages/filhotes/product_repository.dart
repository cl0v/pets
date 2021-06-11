import 'package:commons/commons.dart';

class ProductRepository {
  ProductFirebase _firebase = ProductFirebase();
  
  Stream<List<Product>> fetchByCategory(CategoriaFilhote categoria) =>
      _firebase.ref
          .where(Product.pCategory, isEqualTo: categoria.toMap())
          .snapshots()
          .map((query) => query.docs.map((e) => e.data()).toList());

  Stream<List<Product>> get recentlyAdded => _firebase.ref
      .snapshots()
      .map((p) => p.docs.map((e) => e.data()).toList());

  StoreFirebase _storeFirebase = StoreFirebase();


  Future<String?> requestPhone(String storeId) async {
    var s = await _storeFirebase.read(storeId).first;
    return s?.phone;
  }

  Future<String?> requestInstagram(String storeId) async {
     var s = await _storeFirebase.read(storeId).first;
    return s?.instagram;
  }
}
