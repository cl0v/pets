import 'package:commons/commons.dart';

import 'product_repository.dart';

class FilhoteBloc extends SimpleBloc<List<Product>> {
  final _repository = ProductRepository();

  streamByCategory(Categoria c) {
    subscribe(_repository.fetchByCategory(c));
  }

  streamByCategoryWithoutEspecie(String categoria) {
    subscribe(_repository.fetchByCategoryWithoutEspecie(categoria));
  }

  Future<String?> phone(String storeId) async =>
      _repository.requestPhone(storeId);

  Future<String?> instagram(String storeId) async =>
      _repository.requestInstagram(storeId);
}
