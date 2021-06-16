abstract class IAuthentication {
  Future<String> login(String email, String senha);
  String? uid();
  Future logout();
  Future<String> register(String email, String senha);
}
