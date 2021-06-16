import 'package:commons/commons.dart';
import 'package:commons/repositories/category_repository.dart';

class CategoryBloc {
  final CategoryRepository _repository = CategoryRepository();

  Future<CategoriaModelHelper> get future async {
    final list = await _repository.get();
    return list.first;
  }

  Future<List<CategoriaModelHelper>> _fetchCategoryList() {
    return _repository.get();
  }

  Future<List<EspecieModelHelper>> _fetchEspecieListFromCategoryName(
      String c) async {
    final l = await _fetchCategoryList();
    final ct = l.where((ch) => ch.categoria == c).first;
    return ct.especies;
  }
//TODO: Salvar a categoria localmente
  Future<String> fetchEspecieDescription(Categoria c) async {
    final l = await _fetchEspecieListFromCategoryName(c.category);
    var es = l.where((el) => el.nome == c.breed).first;
    return es.about;
  }
}
