import 'package:commons/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationRepository implements IAuthentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<String> login(String email, String senha) async {
    try {
      var user =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      return user.user!.uid;
    } catch (e, exeption) {
      print(e);
      throw exeption;
    }
  }

  @override
  Future logout() async {
    auth.signOut();
  }

  @override
  Future<String> register(String email, String senha) async {
    var c = await auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
         //TODO: Futuramente parar de retornar o ID(nao preciso dele nos users)
    return c.user!
        .uid;
  }
}
