// home_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/location_model.dart';
import '../repository/user_repository/user_repository.dart';
import '../repository/location_repository/location_repository.dart';
import '../widgets/edit_dialog.dart';

class HomeController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final LocationRepository _locationRepository = Get.find<LocationRepository>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    nameController.text = "pranee";
    _checkLoginStatus();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> _checkLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasLoggedIn = prefs.getBool('hasLoggedIn') ?? false;
      print("Login status flag: $hasLoggedIn");

      if (hasLoggedIn) {
        await Future.delayed(Duration(seconds: 1));
        _showEditProfileDialog();
        await prefs.setBool('hasLoggedIn', false);
      }
    } catch (e) {
      print("Error checking login status: $e");
      Get.snackbar(
        "Error",
        "Failed to check login status: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> _handleLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("Location service enabled: $serviceEnabled");

      if (!serviceEnabled) {
        Get.dialog(
          AlertDialog(
            title: Text('Turn on Location'),
            content: Text(
              'Please turn on your location to continue using the app.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('NOT NOW'),
              ),
              TextButton(
                onPressed: () async {
                  Get.back();
                  await Geolocator.openLocationSettings();
                },
                child: Text('TURN ON'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      print("Initial permission status: $permission");

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("Permission after request: $permission");

        if (permission == LocationPermission.denied) {
          Get.dialog(
            AlertDialog(
              title: Text('Location Access'),
              content: Text(
                'Allow RentIt to access your location to find rentals near you.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('DENY'),
                ),
                TextButton(
                  onPressed: () async {
                    Get.back();
                    permission = await Geolocator.requestPermission();
                  },
                  child: Text('ALLOW'),
                ),
              ],
            ),
            barrierDismissible: false,
          );
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );
      print("Retrieved position: ${position.latitude}, ${position.longitude}");
      currentPosition.value = position;

      String? email = FirebaseAuth.instance.currentUser?.email;
      print("Current user email: $email");

      if (email != null) {
        try {
          // Create LocationModel instance
          LocationModel locationModel = LocationModel(
            latitude: position.latitude,
            longitude: position.longitude,
          );

          // Use repository to save location
          await _locationRepository.saveLocation(locationModel, email);
          print("Location saved to Firebase successfully");

          Get.snackbar(
            "Location Updated",
            "Your location has been updated successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        } catch (e) {
          print("Error saving to Firebase: $e");
          throw e;
        }
      } else {
        print("No user email found");
        throw Exception("User email not found");
      }
    } catch (e) {
      print("Error in location handling: $e");
      Get.snackbar(
        "Error",
        "Failed to get location: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  void _showEditProfileDialog() {
    print("Showing edit profile dialog");
    Get.dialog(
      ProfileEditDialog(
        nameController: nameController,
        phoneController: phoneController,
        onSave: _saveProfileChanges,
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _saveProfileChanges() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = FirebaseAuth.instance.currentUser?.email ?? "";

    if (name.isEmpty || phone.isEmpty) {
      Get.snackbar(
        "Error",
        "Name and phone number are required!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    try {
      // Set loading state
      isLoading(true);

      if (email.isNotEmpty) {
        // Create and save user profile
        UserModel userProfile = UserModel(name: name, phone: phone);
        await _userRepository.createUser(userProfile, email);

        // Close the dialog immediately
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Ensure the dialog is closed
        }

        // Show success message
        Get.snackbar(
          "Success",
          "Profile saved successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );

        // Add a small delay before requesting location permission
        await Future.delayed(Duration(milliseconds: 500));

        // Request location permission
        await _handleLocationPermission();
      } else {
        Get.snackbar(
          "Error",
          "Failed to retrieve email address",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print("Error saving profile: $e");
      Get.snackbar(
        "Error",
        "Failed to save profile data: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      // Reset loading state
      isLoading(false);
    }
  }

  void checkLoginStatus() {
    _checkLoginStatus();
  }

  Future<void> updateLocation() async {
    await _handleLocationPermission();
  }
}
