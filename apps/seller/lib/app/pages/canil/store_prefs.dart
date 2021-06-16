import 'dart:convert';
import 'package:commons/commons.dart';

extension StorePrefs on Store {

  
  static Future<Store?> get() async {
    final json = await Prefs.get('canil.prefs');
    if (json != null) return json.isEmpty ? null : Store.fromJson(json);
    return null;
  }

  Future<void> save() async{
    String json = jsonEncode(toMapWithReference());
    await Prefs.put('canil.prefs', json);
  }

  static clear() {
    Prefs.put('canil.prefs', '');
  }


}
