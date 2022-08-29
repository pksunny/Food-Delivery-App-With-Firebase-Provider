
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes_name.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/home_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/email_password_signin.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/email_password_signup.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/sign_in_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings setings) {

    switch(setings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.signin:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case RoutesName.emailsignup:
        return MaterialPageRoute(builder: (context) => EmailPasswordSignup());
      case RoutesName.emailsignin:
        return MaterialPageRoute(builder: (context) => EmailPasswordSignin());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}