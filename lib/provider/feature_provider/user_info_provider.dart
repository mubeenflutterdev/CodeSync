// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesync/model/user_model.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';
import 'package:codesync/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UserInfoProivder with ChangeNotifier {
  UserModel? userInfo;
  bool isLoading = false;
  final _userUid = FirebaseAuth.instance.currentUser!.uid;

  ///    demo data anf methods not necessory

  String phoneNumber = '';
  Future changeGender(String newGender, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_userUid).update(
        {'gender': newGender},
      );
      ToastUtil.showToast(context, message: 'Gender Changed');

      getUserInfo(context);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  Future chnageNumber(newNumber, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_userUid).update(
        {'phone': newNumber},
      );
      ToastUtil.showToast(context, message: 'Number Changed');

      getUserInfo(context);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  Future changeAdress(newAdress, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_userUid).update(
        {'address': newAdress},
      );
      ToastUtil.showToast(context, message: 'Adress Changed');
      getUserInfo(context);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  Future getUserInfo(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final ref = FirebaseFirestore.instance;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot = await ref
          .collection('users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        userInfo = UserModel.fromFireStore(data);
        notifyListeners();
        ToastUtil.showToast(context, message: 'Succesfully fetched');
      } else {
        ToastUtil.showToast(context, message: 'User not found');
      }
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future addUserInfo(
    BuildContext context,
    String email,
    password,
    String name,
    String imgUrl,
    String phone,
  ) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      UserModel userModel = UserModel(
        uid: userId,
        fullName: name,
        email: email,
        role: 'visiter',
        createdAt: DateTime.now(),
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(userModel.toFireStore());
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  Future changeName(BuildContext context, newName) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_userUid).update(
        {'fullName': newName},
      );
      getUserInfo(context);
      ToastUtil.showToast(context, message: 'Name Changed Sucessfully');
      notifyListeners();
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  // uploading user profile image to firebase storage


 




Future<String?> uploadUserProfileImage(BuildContext context) async {
  final userProvider = Provider.of<UserInfoProivder>(context, listen: false);

  try {
    // ✅ Handle permission based on Android version
    PermissionStatus permissionStatus;

    if (Platform.isAndroid) {
      permissionStatus = await Permission.photos.status;

      if (!permissionStatus.isGranted) {
        // Try both photos and storage
        permissionStatus = await Permission.photos.request();
        if (!permissionStatus.isGranted) {
          permissionStatus = await Permission.storage.request();
        }
      }
    } else {
      // iOS
      permissionStatus = await Permission.photos.request();
    }

    if (!permissionStatus.isGranted) {
      ToastUtil.showToast(context, message: 'Permission denied to access gallery.');
      return null;
    }

    // ✅ Pick image
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedImage == null) {
      ToastUtil.showToast(context, message: 'No image selected.');
      return null;
    }

    final File imageFile = File(pickedImage.path);
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    debugPrint("📸 Picked image path: ${pickedImage.path}");
    debugPrint("📁 File exists: ${imageFile.existsSync()}");

    // ✅ Upload to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/userProfileImage/$uid.jpg");

    debugPrint("⏫ Uploading to: images/userProfileImage/$uid.jpg");

    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask;

    // ✅ Get download URL
    final String downloadURL = await snapshot.ref.getDownloadURL();
    debugPrint("✅ Image uploaded: $downloadURL");

    // ✅ Update Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'profileImage': downloadURL});

    // ✅ Refresh local user data
    await userProvider.getUserInfo(context);

    return downloadURL;
  } catch (e) {
    debugPrint("❌ Upload failed: $e");
    ToastUtil.showToast(context, message: 'Upload failed: ${e.toString()}');
    return null;
  }
}


}
