import 'package:commons/commons.dart';
import 'package:seller/app/pages/authentication/authentication_firestore.dart';

import '../user_model.dart';

class RegisterBloc extends SimpleBloc<bool> {
  Future<bool> register(
    String email,
    String senha,
    UserModel u,
  ) async {
    add(true);

    var response = await AuthenticationFirestore.register(email, senha, u);

    add(false);

    return response;
  }
}
