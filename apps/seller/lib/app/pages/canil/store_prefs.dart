
import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:pedigree_seller/app/services/shared_local_storage_service.dart';

extension StorePrefs on Store {
  static Future<Store?> get() async {
    final json = await Prefs.get('canil.prefs');
    if (json != null) return json.isEmpty ? null : Store.fromJson(json);
    return null;
  }

  save() {
    String json = jsonEncode(toMapWithReference());
    Prefs.put('canil.prefs', json);
  }

  static clear() {
    Prefs.put('canil.prefs', '');
  }


}
