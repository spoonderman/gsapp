//first screen seen by first time user
//Contains two buttons "Household" and "Business" which denotes the user's account type
import 'package:compost_test/screens/AuthenticatePage/Register.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToRegistrationScreen(BuildContext context, String accountType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Register(accountType: accountType),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
              width: 16,
            ),
            const Image(
              image: AssetImage('images/greensteps.png'),
              height: 50,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 5,
              width: 16,
            ),
            const Text(
              "Food Waste to Wealth",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Color(0xff4eb447),
              ),
            ),
            const SizedBox(
              height: 30,
              width: 16,
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontSize: 14.3,
                  color: Color(0xff000000),
                ),
                children: [
                  TextSpan(
                    text: 'Build a greener tomorrow',
                  ),
                  TextSpan(
                    text: ' one green step at a time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4eb447),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 38,
              width: 16,
            ),
            const Align(
              alignment: Alignment(-0.6, 0.0),
              child: Text(
                "Account Registration",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontSize: 11,
                  color: Color(0xff000000),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              width: 16,
            ),
            MaterialButton(
              onPressed: () {
                _navigateToRegistrationScreen(context, "household");
                // Navigator.pushNamed(context, 'Register');
              },
              color: const Color(0xff4eb447),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(16),
              textColor: const Color(0xffffffff),
              height: 40,
              minWidth: 260,
              child: const Text(
                "Household",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
              width: 16,
            ),
            MaterialButton(
              onPressed: () {
                _navigateToRegistrationScreen(context, "business");
                // Navigator.pushNamed(context, 'Register');
              },
              color: const Color(0xff4eb447),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(16),
              textColor: const Color(0xffffffff),
              height: 10,
              minWidth: 260,
              child: const Text(
                "Business",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(
              height: 70,
              width: 16,
            ),
            const Image(
              image: AssetImage('images/hug.png'),
              height: 120,
              width: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
