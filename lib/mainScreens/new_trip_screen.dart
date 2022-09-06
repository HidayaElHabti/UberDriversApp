import 'dart:async';

import 'package:drivers_app/assistants/black_theme_google_map.dart';
import 'package:drivers_app/models/user_ride_request_info.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewTripScreen extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;

  NewTripScreen({
    this.userRideRequestDetails,
  });

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  GoogleMapController? newTripGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? buttonTitle = "Arrived";
  Color? buttonColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //google map
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newTripGoogleMapController = controller;

              //black theme google map
              blackThemeGoogleMap(newTripGoogleMapController);
            },
          ),

          //ui
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white30,
                    blurRadius: 18,
                    spreadRadius: .5,
                    offset: Offset(0.6, 0.6),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    //duration
                    Text(
                      "18 mins",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.grey,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //user name - icon
                    Row(
                      children: [
                        Text(
                          widget.userRideRequestDetails!.userName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    //user PickUp Address with icon
                    Row(
                      children: [
                        Image.asset(
                          "images/origin.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.userRideRequestDetails!.originAddress!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    //user DropOff Address with icon
                    Row(
                      children: [
                        Image.asset(
                          "images/destination.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget
                                  .userRideRequestDetails!.destinationAddress!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 10.0),

                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                      ),
                      icon: const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
