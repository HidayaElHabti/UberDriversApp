import 'package:drivers_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging() async {
    //terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {}
    });
    //forground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {});
    //background
    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage? remoteMessage) {});
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
