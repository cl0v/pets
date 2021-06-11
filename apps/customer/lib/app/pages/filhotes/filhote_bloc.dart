import 'package:commons/commons.dart';

import 'product_repository.dart';

class FilhoteBloc extends SimpleBloc<List<Product>> {
  final _repository = ProductRepository();

  byCategoria(CategoriaFilhote categoriaFilhote) {
    try {
      subscribe(_repository.fetchByCategory(categoriaFilhote));
    } catch (e) {}
  }

  Future<String?> phone(String storeId) async =>
      _repository.requestPhone(storeId);

  Future<String?> instagram(String storeId) async =>
       _repository.requestInstagram(storeId);
}
