//User registers to create an account in this screen
//After pressing the "Continue" button, they are taken to Login.dart
// Data is sent to the database under user node
import 'package:compost_test/screens/constants.dart'; //text field properties in here
import 'package:flutter/material.dart';
import 'package:compost_test/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  final String accountType;
  Register({required this.accountType});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final database = FirebaseDatabase.instance.ref();
  final DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("user");
  final _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _checkboxChecked=false;
  bool isEmailValid(String email) {
    // Regular expression for basic email validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  void registerUser(
    TextEditingController nameController,
    TextEditingController houseNoController,
    TextEditingController addressController,
    TextEditingController cityController,
    TextEditingController postcodeController,
    TextEditingController emailController,
    TextEditingController phoneController,
    TextEditingController passwordController,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      // Store user information in the database
      String userId = userCredential.user!.uid;
      DatabaseReference newUserRef = userRef.push();
      await newUserRef.set({
        'name': nameController.text,
        'houseNo': houseNoController.text,
        'address': addressController.text,
        'city': cityController.text,
        'postcode': postcodeController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'userId': userId,
        'accountType': widget.accountType,
        'Parliamentary': '',
        'DUN': '',
        'daerah': '',
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 16,
                ),
                Image(
                  image: AssetImage('images/greensteps.png'),
                  height: 55,
                  width: 140,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                      fontSize: 22,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                ),
                TextField(
                  controller: nameController,
                  decoration: kTextFieldDecoration,
                ),
                TextField(
                  controller: houseNoController,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'House Number',
                    hintText: '29',
                  ),
                ),
                TextField(
                  controller: addressController,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Address',
                    hintText: 'Jalan Datuk Sulaiman 4',
                  ),
                ),
                TextField(
                  controller: cityController,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'City',
                    hintText: 'Kuala Lumpur',
                  ),
                ),
                TextField(
                  controller: postcodeController,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Postcode',
                    hintText: '60000',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Phone Number',
                    hintText: '0123456789*numbers only*',
                  ),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                          _obscureText =
                              !_obscureText; // Toggle the visibility state
                        });
                      },
                      icon: Icon(Icons.visibility,
                          color: Color(0xffd2dae2), size: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          _checkboxChecked = value!;
                        });
                      },
                      activeColor: Color(0xff4eb447),
                      checkColor: Color(0xffffffff),
                      splashRadius: 20,
                      value: _checkboxChecked,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Color(0xff000000),
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Color(0xff4eb447),
                            ),
                          ),
                          TextSpan(
                            text: ' and\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Color(0xff000000),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Color(0xff4eb447),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  onPressed: () async {
                    bool hasEmptyField = false; // Flag to check for empty fields

                    if (nameController.text.isEmpty ||
                        houseNoController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        postcodeController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        passwordController.text.length < 6) {
                      hasEmptyField = true; // Set the flag to true if any field is empty
                    }

                    if (!_checkboxChecked) {
                      // Display a toast message if the checkbox is not checked
                      Fluttertoast.showToast(
                        msg: "Please agree to the Terms of Service and Privacy Policy.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (hasEmptyField) {
                      // Display a single toast message for empty fields
                      Fluttertoast.showToast(
                        msg: "Please fill in all fields",
                        toastLength: Toast.LENGTH_SHORT,
                      );

                      // Add more specific empty field messages here if needed

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

                      if (!isEmailValid(emailController.text)) {
                        // Display a toast message for badly formatted email
                        Fluttertoast.showToast(
                          msg: "Please enter a valid email address.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    } else {
                      // All fields are valid, perform registration
                      registerUser(
                        nameController,
                        houseNoController,
                        addressController,
                        cityController,
                        postcodeController,
                        emailController,
                        phoneController,
                        passwordController,
                      );
                      Navigator.pushNamed(context, 'Login');
                    }
                  },
                  color: Color(0xff4eb447),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  textColor: Color(0xffffffff),
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 20,
                  width: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an Account?",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Color(0xffd2dae2),
                      ),
                    ),
                    Container(
                      width: 65,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xff4eb447),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
