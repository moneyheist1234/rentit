// main.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentit/repository/location_repository/location_repository.dart';
import 'package:rentit/repository/rental_repository/rental_repository.dart';
import 'package:rentit/repository/user_repository/user_repository.dart';
import 'authentication/google_sign_service.dart';
import 'controllers/home_controller.dart';
import 'controllers/renter_controller.dart';
import 'screens/home.dart';
import 'screens/login&signup/login_screen.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase first
    await initFirebase();

    // Initialize repositories in order
    await initializeDependencies();

    runApp(const MyApp());
  } catch (e) {
    print('Error in main: $e');
    runApp(ErrorApp(error: e.toString()));
  }
}

Future<void> initializeDependencies() async {
  try {
    // Initialize repositories first
    Get.put(UserRepository());
    Get.put(LocationRepository());
    Get.put(RentalRepository());

    // Then initialize services and controllers
    Get.put(AuthService());
    Get.put(HomeController());
    Get.put(RentalController());
  } catch (e) {
    print('Error initializing dependencies: $e');
    throw 'Failed to initialize app dependencies: $e';
  }
}

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: 'AIzaSyC68ONquub-3McfWkTSgzkNU4_Ij0POmU0',
              appId: '1:819900227452:android:18076ab0772596ce020ef9',
              messagingSenderId: '819900227452',
              projectId: 'rentit-ab2ba',
              storageBucket:
                  'rentit-ab2ba.appspot.com', // Make sure this is correct
            )
          : null,
    );
    print('Firebase initialized successfully!');
  } catch (e) {
    print('Firebase initialization error: $e');
    throw 'Failed to initialize Firebase: $e';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rent IT',
      theme: ThemeData(
        primaryColor: const Color(0xFF4B5AA8),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF4B5AA8),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          elevation: 8,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4B5AA8),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: FutureBuilder<User?>(
        future: _getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasError) {
            return ErrorScreen(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return LoginScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<User?> _getCurrentUser() async {
    try {
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      print('Error getting current user: $e');
      throw 'Failed to get current user: $e';
    }
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Changed from MaterialApp to GetMaterialApp
      home: ErrorScreen(error: error),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Application Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const MyApp());
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
