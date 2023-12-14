class AuthService {
  static bool isLoggedIn = false;

  static Future<bool> login(String email, String password) async {
    // Add your logic for authentication here (e.g., checking credentials against a database)
    // If authentication is successful, set isLoggedIn to true
    isLoggedIn = true;
    return isLoggedIn;
  }

  static void logout() {
    // Log out the user by resetting the login state
    isLoggedIn = false;
  }
}
