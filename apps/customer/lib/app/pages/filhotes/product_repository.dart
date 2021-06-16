import 'package:commons/commons.dart';

class ProductRepository {
  ProductFirebase _firebase = ProductFirebase();

  Stream<List<Product>> fetchByCategory(Categoria c) => _firebase.ref
      .where(Product.pCategory, isEqualTo: c.toMap())
      .snapshots()
      .map((query) => query.docs.map((e) => e.data()).toList());

  Stream<List<Product>> fetchByCategoryWithoutEspecie(String categoria) =>
      _firebase.ref
          .where(
            "${Product.pCategory}.${Categoria.pCategory}",
            isEqualTo: categoria,
          )
          .snapshots()
          .map((query) => query.docs.map((e) => e.data()).toList());

  Stream<List<Product>> get recentlyAdded => _firebase.ref
      .snapshots()
      .map((p) => p.docs.map((e) => e.data()).toList());

  StoreFirebase _storeFirebase = StoreFirebase();

  Future<String?> requestPhone(String storeId) async {
    var s = await _storeFirebase.read(storeId);
    return s?.phone;
  }

  Future<String?> requestInstagram(String storeId) async {
    var s = await _storeFirebase.read(storeId);
    return s?.instagram;
  }
}
