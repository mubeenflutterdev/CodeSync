import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesync/model/user_model.dart';
import 'package:codesync/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class UserInfoProivder with ChangeNotifier {
  UserModel? userInfo;
  bool isLoading = false;

  ///    demo data anf methods not necessory
  String gender = '';
  String adress = '';
  String phoneNumber = '';
  void changeGender(value) {
    gender = value;
    notifyListeners();
  }

  void chnageNumber(value) {
    phoneNumber = value;
    notifyListeners();
  }

  void changeAdress(value) {
    adress = value;
    notifyListeners();
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
}
