// repository/rental_repository/rental_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../../models/rental_items_model.dart';

class RentalRepository extends GetxController {
  static RentalRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // Upload images to Firebase Storage

// repository/rental_repository/rental_repository.dart

  Future<String> uploadImage(
      File imageFile, String email, String fileName) async {
    try {
      // Generate timestamp for current time (2024-12-14 11:34:59)
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final String uniqueFileName =
          'rental_${timestamp}_${path.basename(fileName)}';

      // Create storage reference
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('rentals')
          .child(email.replaceAll('.', '_'))
          .child(uniqueFileName);

      print('Starting upload to path: ${storageRef.fullPath}');

      // Create metadata
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'uploadedBy': email,
          'uploadTime': DateTime.now().toIso8601String(),
        },
      );

      // Upload file
      final bytes = await imageFile.readAsBytes();
      final UploadTask uploadTask = storageRef.putData(bytes, metadata);

      // Monitor progress
      uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          final progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          print('Upload progress: ${progress.toStringAsFixed(2)}%');
        },
        onError: (error) => print('Upload error: $error'),
        cancelOnError: false,
      );

      // Wait for completion
      final TaskSnapshot snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      print('Upload successful. URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Upload error: $e');
      if (e is FirebaseException) {
        switch (e.code) {
          case 'unauthorized':
            throw 'Not authorized to upload. Please login again.';
          case 'object-not-found':
            throw 'Storage error. Please try again.';
          default:
            throw 'Upload failed: ${e.message}';
        }
      }
      throw 'Failed to upload image: $e';
    }
  }

  // Create new rental listing
  Future<String> createRental(RentalModel rental, String email) async {
    try {
      String rentalId = '';

      await _db.runTransaction((transaction) async {
        // Create rental document
        final rentalRef = _db.collection("Rentals").doc();
        rentalId = rentalRef.id;

        // Set rental data
        transaction.set(rentalRef, rental.toJson());

        // Update user's rentals collection
        final userRentalsRef = _db.collection("UserRentals").doc(email);
        final userRentalsDoc = await transaction.get(userRentalsRef);

        if (userRentalsDoc.exists) {
          transaction.update(userRentalsRef, {
            'activeRentals': FieldValue.arrayUnion([rentalId]),
            'lastUpdated': FieldValue.serverTimestamp(),
          });
        } else {
          transaction.set(userRentalsRef, {
            'activeRentals': [rentalId],
            'rentalHistory': [],
            'lastUpdated': FieldValue.serverTimestamp(),
          });
        }
      });

      print('Rental created with ID: $rentalId');
      return rentalId;
    } catch (e) {
      print('Error creating rental: $e');
      throw 'Failed to create rental: $e';
    }
  }

  // Get user's rental listings
// repository/rental_repository/rental_repository.dart

  Future<List<RentalModel>> getUserRentals(String email) async {
    try {
      // First try without ordering by createdAt
      final snapshot = await _db
          .collection("Rentals")
          .where('userEmail', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        return [];
      }

      return snapshot.docs.map((doc) => RentalModel.fromSnapshot(doc)).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort in memory
    } on FirebaseException catch (e) {
      print('Firebase error fetching rentals: ${e.code} - ${e.message}');
      if (e.code == 'failed-precondition') {
        // Index is still building
        print('Index is building. Using alternative query method.');
        return _getUnorderedRentals(email);
      }
      throw 'Failed to get rentals: ${e.message}';
    } catch (e) {
      print('Error fetching rentals: $e');
      throw 'Failed to get rentals: $e';
    }
  }

// Fallback method while index is building
  Future<List<RentalModel>> _getUnorderedRentals(String email) async {
    try {
      final snapshot = await _db
          .collection("Rentals")
          .where('userEmail', isEqualTo: email)
          .get();

      final rentals =
          snapshot.docs.map((doc) => RentalModel.fromSnapshot(doc)).toList();

      // Sort in memory
      rentals.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return rentals;
    } catch (e) {
      print('Error in fallback rental fetch: $e');
      throw 'Failed to get rentals: $e';
    }
  }

  // Get rental by ID
  Future<RentalModel?> getRentalById(String rentalId) async {
    try {
      final doc = await _db.collection("Rentals").doc(rentalId).get();
      if (!doc.exists) return null;
      return RentalModel.fromSnapshot(doc);
    } catch (e) {
      print('Error fetching rental: $e');
      throw 'Failed to get rental: $e';
    }
  }

  // Delete rental and its images
  Future<void> deleteRental(String rentalId, String email) async {
    try {
      final rental = await getRentalById(rentalId);
      if (rental == null) throw 'Rental not found';

      if (rental.userEmail != email) {
        throw 'Not authorized to delete this rental';
      }

      await _db.runTransaction((transaction) async {
        // Delete rental document
        transaction.delete(_db.collection("Rentals").doc(rentalId));

        // Update user's rentals
        final userRentalsRef = _db.collection("UserRentals").doc(email);
        transaction.update(userRentalsRef, {
          'activeRentals': FieldValue.arrayRemove([rentalId]),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      });

      // Delete associated images
      for (String imageUrl in rental.imageUrls) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(imageUrl);
          await ref.delete();
        } catch (e) {
          print('Warning: Failed to delete image: $e');
        }
      }
    } catch (e) {
      print('Error deleting rental: $e');
      throw 'Failed to delete rental: $e';
    }
  }

  // Update rental status
  Future<void> updateRentalStatus(
      String rentalId, String email, bool isActive) async {
    try {
      await _db.runTransaction((transaction) async {
        final rentalRef = _db.collection("Rentals").doc(rentalId);
        final userRentalsRef = _db.collection("UserRentals").doc(email);

        // Update rental status
        transaction.update(rentalRef, {
          'isActive': isActive,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Update user's rental lists
        if (isActive) {
          transaction.update(userRentalsRef, {
            'activeRentals': FieldValue.arrayUnion([rentalId]),
            'rentalHistory': FieldValue.arrayRemove([rentalId]),
          });
        } else {
          transaction.update(userRentalsRef, {
            'activeRentals': FieldValue.arrayRemove([rentalId]),
            'rentalHistory': FieldValue.arrayUnion([rentalId]),
          });
        }
      });
    } catch (e) {
      print('Error updating rental status: $e');
      throw 'Failed to update rental status: $e';
    }
  }
}
