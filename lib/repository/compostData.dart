import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import '../model/compostModel.dart';

class CompostData {
  static Future<CompostModel?> getUserCompostData(String userId) async {
    // this debugPrint is only for debugging purposes, can delete after
    debugPrint('ni sebelum panggil compostModel: $userId');
    // specify the model to return it
    CompostModel? cData;

    // create a reference to the compostData node in Realtime Database
    DatabaseReference compostRef = FirebaseDatabase.instance.ref().child('compostData').child(userId);
    // .child('compostData') specify the compostData tree
    // .child(userId) specify the tree with the same value as the userId = the current user's data
    // how much child you use depend on how much you need to enter the tree before reaching the data
    // from here can retrieve the data

    // Execute the query and get the data
    // limit to last make sure that you get the latest data
    final event = compostRef.orderByKey().limitToLast(1);
    final snapchat = await event.once();
    //debugPrint('event =================: ${snapchat.snapshot.value.toString()}');


    // Extract each user entry from the snapchat
    Map<dynamic, dynamic> compostDataRaw = snapchat.snapshot.value as Map<dynamic, dynamic>;

    // this will convert it into the appropriate model for easier data handling
    if(compostDataRaw.isNotEmpty) {
      String key = compostDataRaw.keys.first;
      Map<String, dynamic> userCData = Map<String, dynamic>.from(compostDataRaw[key] as Map<dynamic, dynamic>);

      // Create a CompostModel object
      cData = CompostModel.fromJson(userCData);
    }
    return cData;
  }
}



