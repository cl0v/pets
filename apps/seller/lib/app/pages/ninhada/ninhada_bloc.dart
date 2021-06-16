import 'package:commons/commons.dart';
import 'package:commons/models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';

class ProductBloc {
  ProductFirebase _repository = ProductFirebase();

  final productListStream = SimpleBloc<List<Product>>();

  void init() async {
    final store = await StoreBloc().fetch();
    final stream = _repository.readFromStore(store!.id);
    productListStream.subscribe(stream);
  }

  final createBtnBloc = SimpleBloc<bool>();

  Future<bool> create(
    PlatformFile file,
    Product product,
  ) async {
    try {
      createBtnBloc.add(true);
      final response = await _repository.create(file, product);
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(
    Product product,
  ) async {
    try {
      createBtnBloc.add(true);
      final response = await _repository.update(product);
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      print(e);
      return false;
    }
  }

  delete(Product product) async {
    await _repository.delete(product.id);
  }
}
