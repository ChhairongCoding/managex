class LoginRegisterRepo {
  // final String baseUrl;

  Future<bool> login(String email, String password) async {
    try {
      final String demoEmail = "email";
      final String demoPassword = "123";

      if (email == demoEmail && password == demoPassword) {
        return true;
      } else {
        throw Exception("Invalid email or password");
      }
    } catch (e) {
      throw Exception("Invalid email or password");
    }
  }
}
