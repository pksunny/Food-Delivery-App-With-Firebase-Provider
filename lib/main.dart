// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes.dart';
import 'package:food_delivery_with_provider_using_firebase_app/routes/routes_name.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/home/home_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/screens/signup%20signin/sign_in_screen.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/delivery_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/firebase_auth_method.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/product_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/review_cart_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/wish_list_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initilaization = Firebase.initializeApp();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseAuthMethods()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => ReviewCartProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => DeliveryProvider()),
      ],

      child: GetMaterialApp(
      // initialRoute: RoutesName.signin,
      onGenerateRoute: Routes.generateRoute,
      home: FutureBuilder(
          future: _initilaization,
          builder: ((context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text('Not Connected'),
              );
            }

            if(snapshot.connectionState == ConnectionState.done){
              return SignInScreen();
              // return Center(
              //   child: Text('Connected Successfully!'),
              // );
            }
            
            return Center(
              child: CircularProgressIndicator(),
            );
          })
          ),
    ),
    );
  }
}

