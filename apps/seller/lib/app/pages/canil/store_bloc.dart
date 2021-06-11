import 'package:commons/commons.dart';
import 'package:pedigree_seller/app/pages/canil/store_prefs.dart';

class StoreBloc {
  StoreBloc(this.userId, {this.canil}) {
    bloc.add(canil);
  }

  final String userId;
  Store? canil;

  final createBtnBloc = SimpleBloc<bool>();
  final bloc = SimpleBloc<Store?>();

  StoreFirebase _respository = StoreFirebase();

  Future<Store?> create(Store s) async {
    //TODO: Receber o model
    try {
      createBtnBloc.add(true);
      s = s
        ..userId = userId
        ..save();
      await _respository.create(s);
      createBtnBloc.add(false);

      return s;
    } catch (e) {}
  }

  Future<Store?> get() async {
    var c = await StorePrefs.get();
    if (c == null) {
      c = await _respository.read(userId).first;
      //Tenho uma stream la, posso bindar
      if (c != null) {
        c.save();
      }
    }
    bloc.add(c);
    return c;
  }
}
