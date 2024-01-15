// First time user will enter this screen after loggin in
//If user is already signed in, this is the first screen that is shown
//contains side drawer and navigation bar which switches between MainScreen.dart & Compost.dart
//home button is Mainscreen(),
// |+| button is Compost(),
// Profile button opens a side drawer
//TODO: Issue with fetching and displaying data in drawer, Fields: "accountType","name", "phone"

import 'package:flutter/material.dart';
import 'package:compost_test/screens/UserPage/Compost.dart';
import 'package:compost_test/screens/UserPage/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class MainScreenBar extends StatefulWidget {
  @override
  State<MainScreenBar> createState() => MainScreenBarState();
}

class MainScreenBarState extends State<MainScreenBar> {
  final database = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final userRef = FirebaseDatabase.instance.ref().child('user').child(userId);
  final compostDataRef =
      FirebaseDatabase.instance.ref().child('compostData').child(userId);
  double cumulativeWeight = 0;
  double cumulativeGreenpoints = 0;
  double cumulativeCO2e = 0;
  late Future<Map<String, dynamic>> userData;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    loggedInUser = _auth.currentUser!;
    userData = getUserData(loggedInUser.uid);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser.email);
        fetchCompostData();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    DataSnapshot snapshot = await userRef.get();

    if (snapshot.value != null && snapshot.value is Map) {
      // Check if the snapshot value is not null and is of type Map

      // Convert the snapshot value to a Map
      Map<String, dynamic> userDataMap = Map<String, dynamic>.from(snapshot.value as Map);

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

  int _currentPageIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    Compost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Color(0xffffffff),
          backgroundColor: Color(0xffffffff),
          elevation: 20,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
            ),
          ),
        ),
        child: NavigationBar(
          height: 80,
          onDestinationSelected: (int index) {
            if (index == 2) {
              _drawerKey.currentState?.openDrawer(); // Open the drawer
              return; // Exit the method
            }
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Icon(
                    Icons.add_box,
                    size: 80,
                    color: Color(0xff4eb447),
                  )),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_circle,
                size: 30,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: [
        MainScreen(),
        Compost(),
      ][_currentPageIndex],
      key: _drawerKey,
      drawer: SafeArea(
        child: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Color(0xff4eb447),
                          size: 24,
                        ),
                      ),
                    ),
                    Text(
                      'Household Account',
                      style: TextStyle(
                          color: Color(0xff4eb447),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: userData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            Map<String, dynamic> userData =
                                snapshot.data as Map<String, dynamic>;
                            return Text(
                              '${userData['name']}',
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '0123456789',
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${cumulativeGreenpoints.toStringAsFixed(2)} GreenPoints',
                      style: TextStyle(
                          color: Color(0xff4eb447),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${cumulativeCO2e.toStringAsFixed(2)} KgCO2e',
                      style: TextStyle(
                          color: Color(0xff4eb447),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color(0xffd2dae2),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 1,
                  title: const Text(
                    'Home',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 1,
                  title: const Text(
                    'Switch Accounts',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 36,
                  title: const Text(
                    'Get in Touch',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 1,
                  title: const Text(
                    'Terms of Service',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 20,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 28,
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xffd2dae2),
                  ),
                  horizontalTitleGap: 1,
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, 'HomeScreen');
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(56, 0, 0, 0),
                  child: Text(
                    'version 1.0',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Image(
                      image: AssetImage('images/greensteps.png'),
                      height: 50,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
