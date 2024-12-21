import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Fetch user email
  static Future<String?> getUserEmail() async {
    var user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  // Sign-in with Google and update SharedPreferences
  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false; // User canceled login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      // After successful login, set the login flag in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasLoggedIn', true); // Set the flag to true after login

      // Ensure HomeController is registered before calling its methods
      if (!Get.isRegistered<HomeController>()) {
        Get.put(HomeController()); // Register HomeController
      }

      // Notify the HomeController to check login status
      HomeController controller = Get.find<HomeController>();
      controller.checkLoginStatus(); // Trigger dialog check

      return true;
    } catch (e) {
      print("Error signing in with Google: $e");
      return false;
    }
  }

  // Sign out of both Firebase and Google
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      // Reset the login flag in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('hasLoggedIn', false); // Reset flag after sign out
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // Get current authenticated user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
