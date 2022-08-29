
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/base_controller.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


// ENUM //
enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthController with ChangeNotifier {

  var userId;

  // GOOGLE SIGNIN //
  Future<User?> googleSignUp() async {

    try {

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ]
      );

      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await auth.signInWithCredential(credential)).user;

      print("Signed in : " + user!.displayName.toString());

      return user;

      
    } catch (e) {
      
    }
  }

  // SIGNUP //
  Future<void> signUp(email, password, username) async {
    try {
      CommonDialog.showLoading();
      // AUTHENTICATING USER //
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.toString(),
              password: password);

      print(userCredential);
      CommonDialog.hideLoading();
      // ADDING USER DATA IN DATABASE //
      try {
        CommonDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('userslist').add({
          'user_Id': userCredential.user!.uid,
          'user_name': username,
          "password": password,
          'joinDate': DateTime.now().millisecondsSinceEpoch,
          'email': email
        });
        print("Firebase response ${response.id}");
        CommonDialog.hideLoading();
       
      } catch (exception) {
        CommonDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }

      Get.back();

    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      if (e.code == 'weak-password') {
        CommonDialog.showErrorDialog(description: 'The password provided is too weak!');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonDialog.showErrorDialog(description: 'The account already exists for that email!');
        print('The account already exists for that email.');
      }
    } catch (e) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog(description: "Something went wrong");
      print(e);
    }
  }

  // LOGIN //
  Future<void> signIn(email, password) async {

    print('$email , $password');
    try {
      CommonDialog.showLoading();
      // AUTHETICATIN USER //
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email,
              password: password);

      print(userCredential.user!.uid);
      // SAVING LOGGED IN USERID IN VARIABLE //
      userId = userCredential.user!.uid;
      
      CommonDialog.hideLoading();

      // AFTER LOGIN GOTO HOMESCREEN
      // Get.off(() => HomeScreen());

    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommonDialog.showErrorDialog(description: 'No user found for that email');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommonDialog.showErrorDialog(description: 'Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }
  }

  //  _-_-_-_-_-_-_-_- SIGN OUT _-_-_-_-_-_-_-_-
  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}