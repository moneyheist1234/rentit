import 'package:get/get.dart';
import '../authentication/google_sign_service.dart';
import '../repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final AuthService _authRepo = Get.put(AuthService());
  final UserRepository _userRepo = Get.put(UserRepository());

  getUserData() {
    final user = AuthService.getCurrentUser(); // Use getCurrentUser() here

    if (user != null) {
      return _userRepo
          .getUserDetails(user.email!); // Fetch user data with email
    } else {
      Get.snackbar("Error", "Please log in to continue");
    }
  }
}
