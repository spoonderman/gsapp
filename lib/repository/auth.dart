import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/UserModel.dart';

class auth {
  static Future<UserModel?> getUserDataCollection(String userUid) async {
    debugPrint('ni sebelum panggil: $userUid');
    UserModel? userInfo;

    // Create a reference to the user node in Realtime Database.
    DatabaseReference userRef = FirebaseDatabase.instance.reference().child('user');

    // Execute the query and get the results.
    DatabaseEvent event = await userRef.orderByChild('email').equalTo(userUid).once();

    // Extract each user entry from the snapshot
    Map<dynamic, dynamic> usersDataRaw = event.snapshot.value as Map<dynamic, dynamic>;

    if (usersDataRaw.isNotEmpty) {
      String key = usersDataRaw.keys.first;
      Map<String, dynamic> userData = Map<String, dynamic>.from(usersDataRaw[key] as Map<dynamic, dynamic>);

      // Create a UserModel object
      userInfo = UserModel.fromJson(userData);
    }
      return userInfo;
  }
}


