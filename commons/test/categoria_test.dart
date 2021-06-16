import 'dart:convert';
import 'dart:io';

import 'package:commons/repositories/category_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Testando categoria from json', () async {
    final file = new File('test_resources/jsons/categorias.json');
    final json = jsonDecode(await file.readAsString());
    print(json["version"]);
    CategoriaModelHelper cat =
        CategoriaModelHelper.fromMap(json["categories"].first);
    expect(cat.categoria, "Cachorro");
    expect(cat.especies.first.nome, "Shih Tzu");
// CategoriaModelHelper cat = CategoriaModelHelper.fromMap(json.first);
  });
}
