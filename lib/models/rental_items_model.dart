// models/rental_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class RentalModel {
  final String itemName;
  final String category;
  final double rentPerDay;
  final String renterName;
  final String renterPhone;
  final List<String> imageUrls;
  final String address;
  final String city;
  final String zipCode;
  final String userEmail;
  final DateTime createdAt;

  RentalModel({
    required this.itemName,
    required this.category,
    required this.rentPerDay,
    required this.renterName,
    required this.renterPhone,
    required this.imageUrls,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.userEmail,
    required this.createdAt,
  });

  factory RentalModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return RentalModel(
      itemName: data['itemName'] ?? '',
      category: data['category'] ?? '',
      rentPerDay: (data['rentPerDay'] ?? 0.0).toDouble(),
      renterName: data['renterName'] ?? '',
      renterPhone: data['renterPhone'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      zipCode: data['zipCode'] ?? '',
      userEmail: data['userEmail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'category': category,
      'rentPerDay': rentPerDay,
      'renterName': renterName,
      'renterPhone': renterPhone,
      'imageUrls': imageUrls,
      'address': address,
      'city': city,
      'zipCode': zipCode,
      'userEmail': userEmail,
      'createdAt': createdAt,
    };
  }
}
