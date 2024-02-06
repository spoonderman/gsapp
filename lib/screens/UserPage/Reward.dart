// Final step in UI flow
//User reaches this screen by pressing "Submit" in Compost.dart
// Shows user the number their Green Points and CO2e reduction
//Back arrow at top of screen causes user to return to "Compost.dart"
//TODO: Error in fetching data from database, the value displayed isn't up to date
import 'package:flutter/material.dart';
import 'package:compost_test/screens/UserPage/Compost.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Does not contain bottom navigation bar

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => RewardState();
}

class RewardState extends State<Reward> {
  final _auth=FirebaseAuth.instance;

  final database = FirebaseDatabase.instance.ref();
  final userRef = FirebaseDatabase.instance.ref().child('user').child(userId);
  final compostDataRef =
  FirebaseDatabase.instance.ref().child('compostData').child(userId);
  double weight = 0;
  double greenpoints = 0;
  double CO2e = 0;

  @override
  void initState() {
    super.initState();
    fetchCompostData();
  }


  void fetchCompostData() async {
    try {
      weight = 0;
      greenpoints = 0;
      CO2e = 0;
      DataSnapshot snapshot = await compostDataRef.get();
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic> data = snapshot.value as Map;
        data.forEach((key, value) {
          if (value is Map &&
              value.containsKey('weight') &&
              value.containsKey('greenpoints') &&
              value.containsKey('co2e')) {
            weight = double.parse(value['weight'].toString());
            greenpoints =
                double.parse(value['greenpoints'].toString());
            CO2e = double.parse(value['co2e'].toString());
          }
        });
        setState(() {}); // Refresh the UI
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                        },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff4eb447),
                        size: 24,
                      ),
                    ),

                    const Image(
                      image: AssetImage('images/greensteps.png'),
                      height: 50,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                const Divider(
                  color: Color(0xffd2dae2),
                  thickness: 3,
                ),
                const SizedBox(
                  height: 16,
                  width: 16,
                ),
                const Text(
                  "Great Job!",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                ),

                const Image(
                  image: AssetImage('images/Reward.png'),
                  height:130,
                  fit: BoxFit.contain,
                ),

                const Text(
                  "You've earned",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: greenpoints.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff4eb447),
                        ),
                      ),
                      const TextSpan(
                        text: ' GreenPoints',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Icon(
                  Icons.add,
                  color: Color(0xff212435),
                  size: 24,
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Reduced',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: ' ${CO2e.toStringAsFixed(2)} kg',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff4eb447),
                        ),
                      ),
                      const TextSpan(
                        text: ' CO2 equivalent',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:180,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
