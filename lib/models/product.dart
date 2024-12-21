import 'package:flutter/foundation.dart';

class Product {
  final String title;
  final String price; // Ensure this is non-nullable
  final String rentCategory;
  final String location;
  final String imageUrl;
  final String rentalTime;

  Product({
    required this.title,
    required this.price, // Ensure this is non-nullable
    required this.rentCategory,
    required this.location,
    required this.imageUrl,
    required this.rentalTime,
  });
}
