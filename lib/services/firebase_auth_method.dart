// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/controller/common_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/models/user_profile_model.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes_name.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/home_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/sign_in_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/show_otp_dialog.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/show_snack_bar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods with ChangeNotifier {


  // GET USER DATA ON HOME SCREEN LOAD
  void onReady() {
    getUserProfileData();
  }

  
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseAuthMethods(this._auth);

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // EMAIL SIGN UP
  Future<void> signUpWithEmail(username, email, password) async {
    try {

      // AUTHENTICATE USER //
      CommonDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await sendEmailVerification(context);

      print('user Credential => $userCredential');

      CommonDialog.hideLoading();

      // ADDING USER DATA IN DATABASE //
      try {
        CommonDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('userslist').add({
          'user_Id': userCredential.user!.uid,
          'user_name': username,
          "password": password,
          'email': email
        });
        print("Firebase response ${response.id}");
        CommonDialog.hideLoading();
       
      } catch (exception) {
        CommonDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }

      notifyListeners();

      Get.back();
      
      CommonDialog.showErrorDialog(title: 'Congrats', description: 'User Added Successfully!');

    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        CommonDialog.showErrorDialog(description: 'The password provided is too weak!');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonDialog.showErrorDialog(description: 'The account already exists for that email!');
        print('The account already exists for that email.');
      }// Displaying the usual firebase error message
    } catch(e) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog(description: "Something went wrong");
      print(e);
    }
  }

  //USER ID
  var userId;
  var username;
  var useremail;

  // EMAIL LOGIN //
  Future<void> emailSignIn(email, password) async {

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
      username = userCredential.user!.displayName;
      useremail = userCredential.user!.email.toString();

      print('Login user id => $userId');
      print('Login user name => $username');
      print('Login user email => $useremail');
      
      CommonDialog.hideLoading();

      notifyListeners();

      // AFTER LOGIN GOTO HOMESCREEN
      Get.off(() => HomeScreen());

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

  // GOOGLE SIGNIN
  Future<void> googleSignUp() async {

    try {
      CommonDialog.showLoading();
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

      userId = user!.uid.toString();

      CommonDialog.hideLoading();

      print('Saved user id is => $userId');
      print("Signed in id: " + user!.uid.toString());
      print("Signed in name : " + user!.displayName.toString());

      Get.off(() => HomeScreen());

      
    } catch (e) {
      
      CommonDialog.showErrorDialog(description: e.toString());
    // ignore: dead_code_catch_following_catch
    } on FirebaseAuthException catch (e) {
      CommonDialog.showErrorDialog(description: e.toString());// Displaying the error message
    }
  }

    // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }


  // GOOGLE SIGNIN
  Future<void> googleSignUpWithDB() async {

    try {
      CommonDialog.showLoading();
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

      // ADDING USER DATA IN DATABASE //
      try {
        CommonDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('googleusers').add({
          'user_Id': user!.uid.toString(),
          'user_name': user.displayName.toString(),
          'email': user.email.toString(),
          'userImage': user.photoURL.toString(),
        });
        print("Firebase response ${response.id}");
        print("GOOGLE USER ADDED TO DB => ${user.displayName}");
        CommonDialog.hideLoading();
       
      } catch (exception) {
        CommonDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }


      userId = user!.uid.toString();
      username = user!.displayName.toString();
      useremail = user!.email.toString();

      CommonDialog.hideLoading();

      print('Saved user id is => $userId');
      print("Signed in id: " + user!.uid.toString());
      print("Signed in name : " + user!.displayName.toString());

      Get.off(() => HomeScreen());

      
    } catch (e) {
      
      CommonDialog.showErrorDialog(description: e.toString());
    // ignore: dead_code_catch_following_catch
    } on FirebaseAuthException catch (e) {
      CommonDialog.showErrorDialog(description: e.toString());// Displaying the error message
    }
  }

  // ANONYMOUS SIGN IN
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // FACEBOOK SIGN IN
  // Future<void> signInWithFacebook(BuildContext context) async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();

  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //     await _auth.signInWithCredential(facebookAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    if (kIsWeb) {
      // !!! Works only on web !!!
      ConfirmationResult result =
          await _auth.signInWithPhoneNumber(phoneNumber);

      // Diplay Dialog Box To accept OTP
      showOTPDialog(
        codeController: codeController,
        context: context,
        onPressed: () async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: result.verificationId,
            smsCode: codeController.text.trim(),
          );

          await _auth.signInWithCredential(credential);
          Navigator.of(context).pop(); // Remove the dialog box
        },
      );
    } else {
      // FOR ANDROID, IOS
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //  Automatic handling of the SMS code
        verificationCompleted: (PhoneAuthCredential credential) async {
          // !!! works only on android !!!
          await _auth.signInWithCredential(credential);
        },
        // Displays a message when verification fails
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        // Displays a dialog box when OTP is sent
        codeSent: ((String verificationId, int? resendToken) async {
          showOTPDialog(
            codeController: codeController,
            context: context,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );

              // !!! Works only on Android, iOS !!!
              await _auth.signInWithCredential(credential);
              Navigator.of(context).pop(); // Remove the dialog box
            },
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    try {
      CommonDialog.showLoading();

      var signout = await FirebaseAuth.instance.signOut();

      await FirebaseAuth.instance.signOut();

      return signout;
      // return await FirebaseAuth.instance.signOut();

      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount() async {
    try {
      print('User id to delete => $userId');
      CommonDialog.showLoading();

      await _auth.currentUser!.delete();
      await FirebaseFirestore.instance
          .collection("userslist")
          .doc(userId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        print('User Account DB Deleted Successfully!');
      });

      CommonDialog.hideLoading();

      print('Account Deleted Successfully!');

      notifyListeners();

      Get.to(SignInScreen());

      CommonDialog.showErrorDialog(title: 'Deleted!', description: 'Account deleted Succesfully!');

    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  // DELETE ACCOUNT DATA FROM DATABASE
  Future<void> deleteAccountDB() async {
    print("User Id" + userId);
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("userslist")
          .doc(userId)
          .delete()
          .then((_) {
        CommonDialog.hideLoading();
        print('User Account DB Deleted Successfully!');
      });
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();
      print(error);
    }
  }


  // GET USER PRFILE DATA FROM DATABASE //
  List<UserProfileModel> yourProfileList = [];

  Future<void> getUserProfileData() async {

    List<UserProfileModel> newList = [];
    
    var value = await FirebaseFirestore.instance
      .collection('userslist')
      .where('user_Id', isEqualTo: userId)
      .get();

    value.docs.forEach(
      (element) {
        print('user data ${element.data()}');
        print('user is => ${element.id}');

        UserProfileModel userProfileModel = UserProfileModel(
          user_Id: element.get('user_Id'),
          user_name: element.get('user_name'), 
          email: element.get('email'), 
        );
        
        newList.add(userProfileModel);
       });

       yourProfileList = newList;
       notifyListeners();
  }

  List<UserProfileModel> get getUserProfileList {
    return yourProfileList;
  }
}