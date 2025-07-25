// ignore_for_file: use_build_context_synchronously

import 'package:codesync/presentation/user_view/profile_view/profile_screen.dart';
import 'package:codesync/provider/feature_provider/user_info_provider.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:codesync/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthentactionProvider with ChangeNotifier {
  bool isSignInLoading = false;
  bool isSignUpLoading = false;
  bool isLogOutLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // signup user
  Future signUpUser(
    BuildContext context,
    String email,
    password,
    String name,
  ) async {
    UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(
      context,
      listen: false,
    );
    try {
      isSignUpLoading = true;
      notifyListeners();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        /// sending email verification
        await user.sendEmailVerification();
        Navigator.pushNamed(context, AppRouteName.logInScreen);
      }

      userInfoProivder.addUserInfo(
        context,
        email,
        password,
        name,
        'imgUrl',
        'phone',
      );

      /// showing a dialog to user to confirm the email
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Verify your email"),
          content: Text(
            "A verification email has been sent to $email.\n\nPlease verify it before logging in.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut(); // Prevent auto login
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      if (user!.emailVerified) {
        Navigator.pushReplacementNamed(context, AppRouteName.profileScreen);
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ProfileScreen()),
      // );
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isSignUpLoading = false;
      notifyListeners();
    }
  }

  // sign in user
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

  /// signout user
  Future signOut(BuildContext context) async {
    try {
      isLogOutLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context, AppRouteName.splashScreen);
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isLogOutLoading = false;
      notifyListeners();
    }
  }

  /// google signin ... user downgraded version of google auth package (google_sign_in: ^6.2.1)
  Future<void> signInWithGoogle(BuildContext context) async {
    //there we initilize get device token controller

    try {
      UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(
        context,
        listen: false,
      );
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );
        final User? user = userCredential.user;
        String email = user!.email.toString();
        String password = 'Google Password';
        String name = user.displayName.toString();
        String imgUrl = user.photoURL.toString();
        String phone = user.phoneNumber.toString();
        userInfoProivder.addUserInfo(
          context,
          email,
          password,
          name,
          imgUrl,
          phone,
        );

        if (user != null) {
          Navigator.pushNamed(context, AppRouteName.profileScreen);
        }
      }
    } catch (e) {
      // EasyLoading.dismiss();
      print(e.toString());
      ToastUtil.showToast(context, message: e.toString());
    }
  }

  /// facebook signin but not tested
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      isSignInLoading = true;
      notifyListeners();

      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token,
        );

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          String email = user.email ?? 'No Email';
          String password = 'Facebook Password';
          String name = user.displayName ?? 'No Name';
          String imgUrl = user.photoURL ?? '';
          String phone = user.phoneNumber ?? '';

          Provider.of<UserInfoProivder>(
            context,
            listen: false,
          ).addUserInfo(context, email, password, name, imgUrl, phone);

          Navigator.pushNamed(context, AppRouteName.profileScreen);
        }
      } else if (result.status == LoginStatus.cancelled) {
        ToastUtil.showToast(context, message: 'Facebook login cancelled');
      } else {
        ToastUtil.showToast(context, message: result.message ?? 'Login failed');
      }
    } catch (e) {
      ToastUtil.showToast(context, message: e.toString());
    } finally {
      isSignInLoading = false;
      notifyListeners();
    }
  }
}
