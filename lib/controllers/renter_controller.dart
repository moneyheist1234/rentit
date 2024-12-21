// controllers/rental_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import '../models/rental_items_model.dart';
import '../repository/rental_repository/rental_repository.dart';

class RentalController extends GetxController {
  final RentalRepository _rentalRepository = Get.find<RentalRepository>();
  final ImagePicker _picker = ImagePicker();

  // Observable variables
  var selectedImages = <File>[].obs;
  var isLoading = false.obs;
  var uploadProgress = 0.0.obs;
  var currentImageIndex = 0.obs;
  var rentals = <RentalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedImages.clear();
    uploadProgress.value = 0.0;
    _loadUserRentals();
  }

  @override
  void onClose() {
    selectedImages.clear();
    super.onClose();
  }

  Future<void> _loadUserRentals() async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      if (email != null) {
        final userRentals = await _rentalRepository.getUserRentals(email);
        rentals.assignAll(userRentals);
      }
    } catch (e) {
      print('Error loading rentals: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      if (selectedImages.length >= 2) {
        Get.snackbar(
          'Limit Reached',
          'You can only select up to 2 images',
          backgroundColor: const Color(0xFFFF9800).withOpacity(0.1),
          colorText: const Color(0xFFFF9800),
        );
        return;
      }

      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        // Validate file size (max 5MB)
        final file = File(image.path);
        final sizeInBytes = await file.length();
        final sizeInMB = sizeInBytes / (1024 * 1024);

        if (sizeInMB > 5) {
          Get.snackbar(
            'Error',
            'Image size should be less than 5MB',
            backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
            colorText: const Color(0xFFF44336),
          );
          return;
        }

        selectedImages.add(file);
        Get.snackbar(
          'Success',
          'Image added successfully',
          backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
          colorText: const Color(0xFF4CAF50),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
        colorText: const Color(0xFFF44336),
      );
    }
  }

  Future<void> removeImage(int index) async {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      Get.snackbar(
        'Success',
        'Image removed successfully',
        backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
        colorText: const Color(0xFF4CAF50),
      );
    }
  }

  Future<List<String>> _uploadImages(String email) async {
    List<String> imageUrls = [];
    currentImageIndex.value = 0;

    for (var i = 0; i < selectedImages.length; i++) {
      currentImageIndex.value = i + 1;
      try {
        final url = await _uploadSingleImage(selectedImages[i], email, i);
        imageUrls.add(url);
      } catch (e) {
        // If any upload fails, cleanup previously uploaded images
        for (var url in imageUrls) {
          try {
            final ref = FirebaseStorage.instance.refFromURL(url);
            await ref.delete();
          } catch (deleteError) {
            print('Error cleaning up uploaded image: $deleteError');
          }
        }
        throw 'Failed to upload image ${i + 1}: $e';
      }
    }

    return imageUrls;
  }

  Future<String> _uploadSingleImage(
      File imageFile, String email, int index) async {
    try {
      final String originalFileName = path.basename(imageFile.path);
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName =
          'rental_${timestamp}_$index${path.extension(originalFileName)}';

      return await _rentalRepository.uploadImage(imageFile, email, fileName);
    } catch (e) {
      print('Error in _uploadSingleImage: $e');
      throw e.toString();
    }
  }

  Future<void> submitRental({
    required String itemName,
    required String category,
    required double rentPerDay,
    required String renterName,
    required String renterPhone,
    required String address,
    required String city,
    required String zipCode,
  }) async {
    try {
      if (!validateRentalData(
        itemName: itemName,
        category: category,
        rentPerDay: rentPerDay.toString(),
        renterName: renterName,
        renterPhone: renterPhone,
        address: address,
        city: city,
        zipCode: zipCode,
      )) {
        return;
      }

      isLoading(true);

      final email = FirebaseAuth.instance.currentUser?.email;
      if (email == null) throw 'User not logged in';

      final List<String> imageUrls = await _uploadImages(email);

      final rental = RentalModel(
        itemName: itemName,
        category: category,
        rentPerDay: rentPerDay,
        renterName: renterName,
        renterPhone: renterPhone,
        imageUrls: imageUrls,
        address: address,
        city: city,
        zipCode: zipCode,
        userEmail: email,
        createdAt: DateTime.now(),
      );

      await _rentalRepository.createRental(rental, email);
      await _loadUserRentals(); // Refresh rentals list

      selectedImages.clear();
      uploadProgress.value = 0.0;

      Get.back();
      Get.snackbar(
        'Success',
        'Rental item added successfully',
        backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
        colorText: const Color(0xFF4CAF50),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print('Error in submitRental: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
        colorText: const Color(0xFFF44336),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  bool validateRentalData({
    required String itemName,
    required String category,
    required String rentPerDay,
    required String renterName,
    required String renterPhone,
    required String address,
    required String city,
    required String zipCode,
  }) {
    if (itemName.isEmpty ||
        category.isEmpty ||
        rentPerDay.isEmpty ||
        renterName.isEmpty ||
        renterPhone.isEmpty ||
        address.isEmpty ||
        city.isEmpty ||
        zipCode.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
        colorText: const Color(0xFFF44336),
      );
      return false;
    }

    if (selectedImages.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select at least one image',
        backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
        colorText: const Color(0xFFF44336),
      );
      return false;
    }

    // Validate phone number format
    if (!renterPhone.isPhoneNumber) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid phone number',
        backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
        colorText: const Color(0xFFF44336),
      );
      return false;
    }

    return true;
  }
}
