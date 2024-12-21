import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String phone;

  UserModel({
    required this.name,
    required this.phone,
  });

  // Factory constructor to create UserModel from Firestore DocumentSnapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserModel(
      name: data?['Name'] ?? '',
      phone: data?['Phone'] ?? '',
    );
  }

  // Convert UserModel to JSON for saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Phone": phone,
    };
  }
}
