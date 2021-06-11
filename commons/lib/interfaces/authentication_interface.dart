abstract class IAuthentication {
  Future<String> login(String email, String senha);
  Future logout();
  Future<String> register(String email, String senha);
}
