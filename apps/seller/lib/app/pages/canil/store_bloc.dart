import 'package:commons/commons.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/pages/canil/store_repository.dart';
import 'package:seller/app/pages/main_screen.dart';

class StoreBloc {
  StoreRepository _repository = StoreRepository();

  Future<UserModel> _fetchUser() => UserBloc().fetch();

  Future<Store?> fetch() async {
    //TODO: Posso remover a possibilidade de ser nulo
    //Terei que mudar em alguns lugares, como na main screen mas talvez valha a pena
    try {
      final u = await _fetchUser();
      final userId = u.id;
      Store? s = await StorePrefs.get();
      if (s == null) {
        s = await _repository.read(userId);
        if (s != null) await s.save();
      }
      return s;
    } on Exception catch (e) {
      print(e);
    }
  }

  final createBtnBloc = SimpleBloc<bool>();

  Future<Store?> create(Store s) async {
    final u = await _fetchUser();
    try {
      createBtnBloc.add(true);
      final store = s..userId = u.id;
      await store.save();
      await _repository.create(store);
      createBtnBloc.add(false);

      return s;
    } catch (e) {}
  }
}
