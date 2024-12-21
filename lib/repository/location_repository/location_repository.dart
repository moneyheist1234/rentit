import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/location_model.dart';

class LocationRepository extends GetxController {
  static LocationRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to save location data in Firestore using email as the document ID
  Future<void> saveLocation(LocationModel location, String email) async {
    try {
      await _db
          .collection("Users")
          .doc(email) // Use email as the document ID
          .collection("Locations")
          .add(location.toJson());

      Get.snackbar(
        "Success",
        "Location has been saved successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to save location",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Method to get all locations for a user using their email
  Stream<List<LocationModel>> getLocations(String email) {
    try {
      return _db
          .collection("Users")
          .doc(email)
          .collection("Locations")
          .snapshots()
          .map((query) {
        return query.docs.map((doc) {
          return LocationModel.fromJson(doc.data());
        }).toList();
      });
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to fetch locations",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      return Stream.value([]);
    }
  }
}
