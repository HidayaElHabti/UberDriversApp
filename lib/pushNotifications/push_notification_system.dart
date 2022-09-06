import 'package:drivers_app/global/global.dart';
import 'package:drivers_app/models/user_ride_request_info.dart';
import 'package:drivers_app/pushNotifications/notification_dialog_box.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    //terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        readUserRideRequestInformation(
            remoteMessage.data["rideRequestId"], context);
      }
    });
    //forground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      readUserRideRequestInformation(
          remoteMessage!.data["rideRequestId"], context);
    });
    //background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      readUserRideRequestInformation(
          remoteMessage!.data["rideRequestId"], context);
    });
  }

  readUserRideRequestInformation(
      String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .once()
        .then((snapData) {
      if (snapData.snapshot.value != null) {
        double originLatitude = double.parse(
            (snapData.snapshot.value! as Map)['origin']['latitude']);
        double originLongitude = double.parse(
            (snapData.snapshot.value! as Map)['origin']['longitude']);
        String originAddress =
            (snapData.snapshot.value! as Map)['originAddress'];

        double destinationLatitude = double.parse(
            (snapData.snapshot.value! as Map)['destination']['latitude']);
        double destinationLongitude = double.parse(
            (snapData.snapshot.value! as Map)['destination']['longitude']);
        String destinationAddress =
            (snapData.snapshot.value! as Map)['destinationAddress'];

        String userName = (snapData.snapshot.value! as Map)['userName'];
        String userPhone = (snapData.snapshot.value! as Map)['userPhone'];

        UserRideRequestInformation userRideRequest =
            UserRideRequestInformation();
        userRideRequest.originLatLng = LatLng(originLatitude, originLongitude);
        userRideRequest.destinationLatLng =
            LatLng(destinationLatitude, destinationLongitude);
        userRideRequest.originAddress = originAddress;
        userRideRequest.destinationLatLng =
            LatLng(destinationLatitude, destinationLongitude);
        userRideRequest.destinationAddress = destinationAddress;

        userRideRequest.userName = userName;
        userRideRequest.userPhone = userPhone;

        showDialog(
          context: context,
          builder: (BuildContext context) => NotificationDialogBox(
            userRideRequestDetails: userRideRequest,
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "This Ride Request doesn not exist.");
      }
    });
  }

  Future generateAndSetToken() async {
    String? registrationToken = await messaging.getToken();
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(currentUser!.uid)
        .child("token")
        .set(registrationToken);
    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");
  }
}
