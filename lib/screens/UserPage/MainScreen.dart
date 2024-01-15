//Can be accessed using bottom navigation bar in MainScreenBar.dart
//Displays the users total ammount of greenpoints, co2e reductions and weight of food waste
// TODO:Add link to greensteps website in blue card

import 'package:flutter/material.dart';
import 'package:compost_test/screens/UserPage/Compost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:compost_test/screens/UserPage/MainScreenBar.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance.ref();
  final userRef = FirebaseDatabase.instance.ref().child('user').child(userId);
  final compostDataRef =
      FirebaseDatabase.instance.ref().child('compostData').child(userId);
  double cumulativeWeight = 0;
  double cumulativeGreenpoints = 0;
  double cumulativeCO2e = 0;
  String userName = "";
  String userPhone = "";
  String userAccountType = "";
  late User loggedInUser;
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    fetchCompostData();
    loggedInUser = _auth.currentUser!;
    userData = getUserData(loggedInUser.uid);
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    DataSnapshot snapshot = await userRef.get();

    if (snapshot.value != null && snapshot.value is Map) {
      // Check if the snapshot value is not null and is of type Map

      // Convert the snapshot value to a Map
      Map<String, dynamic> userDataMap =
          Map<String, dynamic>.from(snapshot.value as Map);

      return userDataMap;
    } else {
      // Handle the case when the snapshot value is not in the expected format

      // In this case, return an empty map
      return {};
    }
  }

  void fetchCompostData() async {
    try {
      DataSnapshot snapshot = await compostDataRef.get();
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic> data = snapshot.value as Map;
        data.forEach((key, value) {
          if (value is Map &&
              value.containsKey('weight') &&
              value.containsKey('greenpoints') &&
              value.containsKey('co2e')) {
            double weight = double.parse(value['weight'].toString());
            cumulativeWeight += weight;
            cumulativeGreenpoints +=
                double.parse(value['greenpoints'].toString());
            cumulativeCO2e += double.parse(value['co2e'].toString());
          }
        });
        setState(() {}); // Refresh the UI
      }
    } catch (e) {
      print(e);
    }
  }

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
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage('images/greensteps.png'),
                    height: 50,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                FutureBuilder(
                    future: userData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        Map<String, dynamic> userData =
                            snapshot.data as Map<String, dynamic>;
                        return Text(
                          "Hello, ${userData['name']}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        );
                      }
                    }),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Get started",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    color: Color(0xff4eb447),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('images/wormer.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Divider(
                  color: Color(0xff808080),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Green  Achievements",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Color(0xff4eb447),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GreenPoints: ${cumulativeGreenpoints.toStringAsFixed(2)}", //Greenpoints is displayed here
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xffffffff),
                            ),
                          ),
                          Text(
                            "CO2e Reduction: ${cumulativeCO2e.toStringAsFixed(2)}", //co2e reduction is displayed here
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xffffffff),
                            ),
                          ),
                          Text(
                            "Food Waste Composted: ${cumulativeWeight.toStringAsFixed(2)}", //total weight is displayed here
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Source Seperation 101",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Color(0xffb4d5f8),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            "Explore how you can easily source seperate waste into three effective categories and contribute to sustainable future",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Color(0xff000000),
                                  ),
                                  foregroundColor: Color(0xff000000),
                                ),
                                onPressed: () {
                                  //link to social media or website, ask Fiona and Jolene
                                },
                                child: Text(
                                  'Learn More',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Why Compost?",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Color(0xfff8dada),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1. Reduce organic waste sent to landfills',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            '2. Reduce harmful greenhouse gas emissions like methane, thats released when food waste decomposes in landfills',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            '3 .Turn organic waste into nutrient-rich compost',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            '4 .Improve soil health and soil structure',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            '5 .Grow nutritous organic food',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
