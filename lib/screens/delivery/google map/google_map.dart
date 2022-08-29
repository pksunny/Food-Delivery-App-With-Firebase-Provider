// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:food_delivery_with_provider_using_firebase_app/services/delivery_provider.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/screen_size.dart';
import 'package:food_delivery_with_provider_using_firebase_app/utils/text_stylz.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  late GoogleMapController googleMapController;

  Location location = Location();

//   Future<void> moveMapCamera(double lat, double lng) async {
//   CameraPosition nepPos = CameraPosition(
//     target: LatLng(lat, lng),
//     zoom: 5,
//   );

//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(nepPos));
// }

  void onMapCreated(GoogleMapController value){

    googleMapController = value;

    location.onLocationChanged.listen((event) { 
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.latitude!.toDouble(), event.longitude!.toDouble()),
            zoom: 15,
          )
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    DeliveryProvider deliveryProvider = Provider.of(context);

    return Scaffold(

      body: SafeArea(
        child: Container(
          height: ScreenSize(context).height,
          width: ScreenSize(context).width,
          child: Stack(
            children: [
      
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: onMapCreated,
                myLocationEnabled: true,
              ),
      
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      
                      await location.getLocation().then((value) {

                        setState(() {
                          deliveryProvider.setLocation = value;
                        });

                        Get.back();

                      });

                    },
                    color: Colors.teal,
                    child: Text('Set Location', style: TextStylz.GuestName,),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}