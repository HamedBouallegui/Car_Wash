class AuthService {
  Future<bool> isLoggedIn() async {
    // In a real app, you'd check for a token, user session, etc.
    // For now, we'll simulate the user not being logged in.
    return false;
  }

  Future<String> getUserRole() async {
    // In a real app, you'd get the role from user data.
    // Defaulting to 'customer' for this example.
    return 'customer';
  }
}
