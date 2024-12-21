import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to create or update user data in Firestore using email as document ID
  Future<void> createUser(user, String email) async {
    try {
      await _db.collection("Users").doc(email).set(user.toJson());
      print("User added to Firestore with email ID as document ID: $email");

      Get.snackbar(
        "Success",
        "Your profile has been updated.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      print("Error adding user to Firestore: $error");
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Method to fetch user details by email
  Future<UserModel?> getUserDetails(String email) async {
    try {
      final document = await _db.collection("Users").doc(email).get();
      if (document.exists) {
        return UserModel.fromSnapshot(document);
      } else {
        print("No user found with email: $email");
        return null;
      }
    } catch (error) {
      print("Error fetching user details by email: $error");
      return null;
    }
  }

  // Method to update user data in Firestore
  Future<void> updateUser(UserModel user, String email) async {
    try {
      await _db.collection("Users").doc(email).update(user.toJson());
      print("User updated in Firestore with email ID: $email");

      Get.snackbar(
        "Success",
        "Your profile has been updated.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      print("Error updating user in Firestore: $error");
      Get.snackbar(
        "Error",
        "Something went wrong while updating profile.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Method to update specific fields in Firestore
  Future<void> updateSpecificFields(
      String email, Map<String, dynamic> fieldsToUpdate) async {
    try {
      await _db.collection("Users").doc(email).update(fieldsToUpdate);
      print("Specific fields updated for user with email: $email");

      Get.snackbar(
        "Success",
        "Profile fields updated successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      print("Error updating specific fields: $error");
      Get.snackbar(
        "Error",
        "Failed to update profile fields",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}
