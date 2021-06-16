import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:seller/app/pages/authentication/firebase_authentication_repository.dart';
//TODO: Testar quando ja existe user com esse email
//TODO: Implementar tratamento de exception para erros especificos

class AuthenticationFirestore {
  static IAuthentication _auth = FirebaseAuthenticationRepository();

  static final String collectionPath = 'users';

  static Future<UserModel?> login(String email, String senha) async {
    try {
      var uid = await _auth.login(email, senha);

      //TODO: Tratar os erros
      //There is no user record corresponding to this identifier. The user may have been deleted.
      var query = await FirebaseFirestore.instance
          .collection(collectionPath)
          .where(UserModel.pUid, isEqualTo: uid)
          .get();

      var referencia = query.docs.first;
      if (referencia.exists) {
        var user = UserModel.fromSnap(referencia);
        return user;
      } else {
        return null;
      }
    } catch (e, ex) {
      print('AUTH STACKTRACE >: $ex');
      print('AUTH EXPECTION >: $e');
      return null;
    }
  }

  static Future<bool> register(
    String email,
    String senha,
    UserModel u,
  ) async {
    try {
      var uid = await _auth.register(email, senha);
      u = u..uid = uid;

      final referencia = await FirebaseFirestore.instance
          .collection(collectionPath)
          .add(u.toMap());

      u
        ..id = referencia.id
        ..save();
      return true;
    } catch (e) {
      return false;
    }
  }
}
