import 'package:commons/commons.dart';
import 'package:commons/models/product.dart';
import 'package:file_picker/file_picker.dart';

class ProductBloc {

  ProductBloc(
    this.canil,
  );

  final Store canil;

  ProductFirebase _repository = ProductFirebase();

  get stream => _repository.readFromStore(canil.id!);

  final createBtnBloc = SimpleBloc<bool>();
  Future<bool> create(
    PlatformFile file,
    Product product,
  ) async {
    try {
      createBtnBloc.add(true);

      final response = await _repository.create(
        file,
        product..storeId = canil.id!,
      );
      createBtnBloc.add(false);
      return response;
    } catch (e) {
      return false;
    }
  }
}
