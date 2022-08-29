import 'package:drivers_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentInfo;
