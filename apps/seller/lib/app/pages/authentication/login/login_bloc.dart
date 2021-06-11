import 'package:commons/commons.dart';
import 'package:seller/app/pages/authentication/authentication_firestore.dart';
import 'package:seller/app/pages/authentication/user_model.dart';

class LoginBloc extends SimpleBloc<bool> {
  
  Future<UserModel?> login(String email, String senha) async {
    add(true);

    var u = await AuthenticationFirestore.login(email, senha);
    if(u !=null) u.save(); 

    add(false);

    return u;
  }
}
