//User reaches this screen using bottom navigation bar in MainScreenBar.dart
//User can input the weight of their food waste
// When user presses "submit" button, Reward.dart screen will pop up
// Data is sent to the database under compostData node

import 'package:compost_test/screens/UserPage/MainScreenBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'Reward.dart';
// Does not contain bottom navigation bar

class Compost extends StatefulWidget {

  @override
  State<Compost> createState() => _CompostState();
}

//initialise firebase auth
FirebaseAuth _auth = FirebaseAuth.instance;
String userId = _auth.currentUser!.uid;

//dropdown button options
List<String> dates = <String>['1/1/23', '2/2/23', '3/3/23'];
List<double> kg = <double>[1.1,2.0,3.0];

class _CompostState extends State<Compost> {
  // String? _topModalData;//top modal sheet package for displaying Reward.dart data
  final database = FirebaseDatabase.instance.ref();
  final userRef = FirebaseDatabase.instance.ref().child('user').child(userId);
  final compostDataRef = FirebaseDatabase.instance.ref().child('compostData').child(userId);
  String dropdownValueDates = dates.first;
  double dropdownValueKg = kg.first;
  double cumulativeWeight = 0;
  double cumulativeGreenpoints = 0;
  double cumulativeCO2e = 0;

  @override
  void initState() {
    super.initState();
    fetchCompostData();
  }

  void fetchCompostData() async {
    try {
      DataSnapshot snapshot = await compostDataRef.get();
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic> data = snapshot.value as Map;
        data.forEach((key, value) {
          if (value is Map && value.containsKey('weight') && value.containsKey('greenpoints') && value.containsKey('co2e')) {
            double weight = double.parse(value['weight'].toString());
            cumulativeWeight += weight;
            cumulativeGreenpoints += double.parse(value['greenpoints'].toString());
            cumulativeCO2e += double.parse(value['co2e'].toString());
          }
        });
        setState(() {}); // Refresh the UI
      }
    } catch (e) {
      print(e);
    }
  }

  void saveCompostData(String dropdownValueDates, double dropdownValueKg, String userId) {
    try {
      DatabaseReference dataRef =
          FirebaseDatabase.instance.ref().child('compostData');

      var userRef = dataRef.child(userId);

      var newEntryRef = dataRef
          .child(userId)
          .push(); // Create a new entry under the user's node

      // Convert the weight string to a double for calculation
      double weight = dropdownValueKg;
      // Calculate greenpoints and co2e based on the formulas
      double greenpoints = 126 * weight;
      double co2e = 1.9 * weight;
      cumulativeWeight += weight;
      cumulativeGreenpoints += greenpoints;
      cumulativeCO2e += co2e;


      //Filling in the fields in firebase console
      newEntryRef.set({
        'date': dropdownValueDates,
        'weight': dropdownValueKg,
        'greenpoints':greenpoints.toStringAsFixed(2),
        'cumulativeGreenPoints':cumulativeGreenpoints.toStringAsFixed(2),
        'co2e':co2e.toStringAsFixed(2),
        'cumulativeCo2e':cumulativeCO2e.toStringAsFixed(2),
        'total weight':cumulativeWeight,
        'userId':userId,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'MainScreenBar');
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xff4eb447),
                        size: 24,
                      ),
                    ),
                    Image(
                      image: AssetImage('images/greensteps.png'),
                      height: 50,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Divider(
                  color: Color(0xffd2dae2),
                  thickness: 3,
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                Text(
                  "Key in your food waste data:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: DropdownButton(
                        value: dropdownValueDates,
                        items:
                            dates.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropdownValueDates = value!;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: DropdownButton(
                        value: dropdownValueKg,
                        items: kg.map<DropdownMenuItem<double>>((value) {
                          return DropdownMenuItem<double>(
                            value: value,
                            child: Text(
                              value.toString(),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) {
                          setState(() {
                            dropdownValueKg = value!;
                          });
                        },
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                MaterialButton(
                  onPressed: () async{
                    saveCompostData(dropdownValueDates, dropdownValueKg, userId);
                    fetchCompostData();
                    Navigator.pushNamed(context, 'Reward');
                    // var value = await showTopModalSheet<String?>(context, Reward(),);
                    //
                    // setState(() { _topModalData = value; });
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   builder: (BuildContext context) {
                    //     return Align(alignment:Alignment.topCenter,child: SingleChildScrollView(child: Reward(),));
                    //   },
                    // );
                  },
                  color: Color(0xff4eb447),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  textColor: Color(0xffffffff),
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('images/composting.png'),
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
