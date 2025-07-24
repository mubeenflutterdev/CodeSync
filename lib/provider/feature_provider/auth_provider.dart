import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesync/model/user_model.dart';
import 'package:codesync/presentation/user_view/profile_view/profile_screen.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:codesync/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthentactionProvider with ChangeNotifier {
  bool isSignInLoading = false;
  bool isSignUpLoading = false;
  bool isLogOutLoading = false;
  Future signUpUser(
    BuildContext context,
    String email,
    password,
    String name,
  ) async {
    try {
      isSignUpLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = FirebaseAuth.instance.currentUser!.uid;
      UserModel userModel = UserModel(
        uid: userId,
        fullName: name,
        email: email,
        createdAt: DateTime.now(),
        address: '',
        phone: 0.toString(),
        profileImage: '',
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(userModel.toFireStore());

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isSignUpLoading = false;
      notifyListeners();
    }
  }

  Future signInUser(BuildContext context, email, password) async {
    try {
      isSignInLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isSignInLoading = false;
      notifyListeners();
    }
  }

  Future signOut(BuildContext context) async {
    try {
      isLogOutLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, AppRouteName.signupScreen);
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isLogOutLoading = false;
      notifyListeners();
    }
  }
  
}
