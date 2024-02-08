//User reaches this screen after registering in Register.dart
//User signs in to their account and presses "Sign In" to enter MainScreenBar.dart
import 'package:flutter/material.dart';
import 'package:compost_test/screens/constants.dart'; //text field properties in here
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    emailController.text = 'abu@gmail.com';
    passwordController.text = 'aaaaaa';
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    child: Image(
                      image: AssetImage('images/greensteps.png'),
                      height: 55,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 85,
                ),
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    fontSize: 22,
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Welcome to GreenSteps!",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Quicksand',
                    fontSize: 14,
                    color: Color(0xffd2dae2),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Email',
                    hintText: '',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Password',
                    hintText: '',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Toggle the visibility state
                        });
                      },
                      icon: const Icon(Icons.visibility,
                          color: Color(0xffd2dae2), size: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                  width: 16,
                ),
                MaterialButton(
                  onPressed: () async {
                    bool hasEmptyField =
                        false; // Flag to check for empty fields

                    if (emailController.text.isEmpty || passwordController.text.length < 6) {
                      hasEmptyField =
                          true; // Set the flag to true if any field is empty
                    }

                    if (hasEmptyField) {
                      // Display a single toast message for empty fields
                      Fluttertoast.showToast(
                        msg: "Please fill in all fields",
                        toastLength: Toast.LENGTH_SHORT,
                      );

                      if (emailController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Please enter your email",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (passwordController.text.length < 6) {
                        Fluttertoast.showToast(
                          msg: "Password must be at least 6 characters long",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                    } else {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: emailController.text, password: passwordController.text);
                        Navigator.pushNamed(context, 'MainScreenBar');
                                            } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Authentication error. Please check your email and password.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM, // Adjust the toast position
                          backgroundColor: Colors.red, // Customize the toast background color
                          textColor: Colors.white, // Customize the text color
                        );
                        print(e);
                      }
                    }
                  },
                  color: const Color(0xff4eb447),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  textColor: const Color(0xffffffff),
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: Color(0xffd2dae2),
                      ),
                    ),
                    const SizedBox(
                      width: 130,
                    ),
                    SizedBox(
                      width: 66,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'Register');
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xff4eb447),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
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
