// models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? phone;
  final String? gender;
  final String? address;
  final String? profileImage;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.phone,
    this.gender,
    this.address,
    this.profileImage,
    required this.createdAt,
  });

  // 🔁 Convert Firestore Document to Dart Object
  factory UserModel.fromFireStore(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      address: map['address'],
      profileImage: map['profileImage'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // 🔁 Convert Dart Object to Firestore Document
  Map<String, dynamic> toFireStore() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'address': address,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }
}
