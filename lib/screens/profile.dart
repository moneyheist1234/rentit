import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentit/bars/custom_fab.dart';
import 'package:rentit/screens/rent_adding_form.dart';
import 'package:rentit/screens/splash_screen/splash_screen.dart';
import '../authentication/google_sign_service.dart';
import '../bars/custom_app_bar.dart';
import '../bars/footer_bar.dart';
import '../bars/side_menu.dart';
import '../constants.dart';
import '../repository/user_repository/user_repository.dart';
import '../controllers/user_controller.dart';
import '../widgets/edit_dialog.dart';
import '../widgets/edit_profile_button.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Initialize UserController
  final UserController _userController = Get.put(UserController());

  String name = 'Loading...';
  String phoneNumber = 'Loading...';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    setState(() => loading = true);
    try {
      final user = AuthService.getCurrentUser();
      if (user != null) {
        final userProfile = await _userController.getUserDetails(user.email!);
        if (userProfile != null) {
          setState(() {
            name = userProfile.name;
            phoneNumber = userProfile.phone;
          });
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch profile data: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      setState(() => loading = false);
    }
  }

  // Show edit profile dialog
  Future<void> _showEditProfileDialog(BuildContext context) async {
    final user = AuthService.getCurrentUser();
    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController phoneController =
        TextEditingController(text: phoneNumber);

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return ProfileEditDialog(
          nameController: nameController,
          phoneController: phoneController,
          onSave: () async {
            try {
              // Update profile in Firebase
              await _userController.updateProfile(
                nameController.text.trim(),
                phoneController.text.trim(),
                user.email!,
              );

              // Refresh the profile data
              await _fetchUserData();

              // Show success message
              Get.snackbar(
                "Success",
                "Profile updated successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green,
              );

              // Close the dialog
              Navigator.of(context).pop();
            } catch (e) {
              Get.snackbar(
                "Error",
                "Failed to update profile: $e",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withOpacity(0.1),
                colorText: Colors.red,
              );
            }
          },
        );
      },
    );
  }

  // Handle logout
  Future<void> _handleLogout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Sign Out",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Are you sure you want to sign out?",
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFDF9F5C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async {
                          await AuthService.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SplashScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileHeader(name: name, phoneNumber: phoneNumber),
                const SizedBox(height: 16.0),
                EditProfileButton(
                  onPressed: () => _showEditProfileDialog(context),
                ),
                const SizedBox(height: 16.0),
                if (loading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kThemeColor),
                  ),
                const SizedBox(height: 24.0),
                SettingsCard(onLogout: () => _handleLogout(context)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FooterBar(),
      floatingActionButton: CustomFAB(targetScreen: RentAddingForm()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
