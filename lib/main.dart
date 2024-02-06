//screen imports
import 'package:flutter/material.dart';
import 'package:compost_test/screens/AuthenticatePage/HomeScreen.dart';
import 'package:compost_test/screens/AuthenticatePage/Register.dart';
import 'package:compost_test/screens/AuthenticatePage/Login.dart';
import 'package:compost_test/screens/UserPage/Reward.dart';
import 'package:compost_test/screens/UserPage/MainScreenBar.dart';
import 'package:compost_test/screens/UserPage/MainScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
//firebase imports
import 'package:compost_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

//code is run from here
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
DatabaseReference userRef=FirebaseDatabase.instance.ref().child("user");
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: AnimatedSplashScreen(
          splash: 'images/splashscreenlogo.png',
          nextScreen:const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          animationDuration: const Duration(seconds:0),
        ),
    onGenerateRoute: (settings) {
      if (settings.name == 'Register') {
        // Extract the accountType from arguments
        String? accountType = settings.arguments as String?;

        return MaterialPageRoute(
          builder: (context) => Register(accountType: accountType ?? ''),
        );
      }
      return null;
    },
        routes: {
          'HomeScreen': (context) => const HomeScreen(),
          'Login': (context) => const Login(),
          'MainScreenBar': (context) => const MainScreenBar(),
          'Reward': (context) => const Reward(),
          'MainScreen':(context)=>const MainScreen(),

        },
      );
  }
}
