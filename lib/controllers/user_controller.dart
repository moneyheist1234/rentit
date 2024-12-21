import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repository/user_repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository.instance;

  // Method to create a user profile
  Future<void> createUserProfile(
      String name, String phone, String email) async {
    try {
      final userProfile = UserModel(name: name, phone: phone);
      await _userRepository.createUser(userProfile, email);
    } catch (e) {
      print("Error in createUserProfile: $e");
    }
  }

  // Method to fetch user details by email
  Future<UserModel?> getUserDetails(String email) async {
    return await _userRepository.getUserDetails(email);
  }

  // Method to check if the profile exists by email
  Future<bool> hasProfile(String email) async {
    try {
      var user = await _userRepository.getUserDetails(email);
      return user != null; // If user data exists, return true
    } catch (e) {
      print("Error in hasProfile: $e");
      return false; // Return false in case of error
    }
  }

  // Method to update user profile
  Future<void> updateProfile(String name, String phone, String email) async {
    try {
      final updatedUserProfile = UserModel(name: name, phone: phone);
      await _userRepository.updateUser(updatedUserProfile, email);
    } catch (e) {
      print("Error in updateProfile: $e");
    }
  }
}
