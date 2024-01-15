//first screen seen by first time user
//Contains two buttons "Household" and "Business" which denotes the user's account type
import 'package:compost_test/screens/AuthenticatePage/Register.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
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
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 16,
            ),
            Image(
              image: AssetImage('images/greensteps.png'),
              height: 50,
              width: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 5,
              width: 16,
            ),
            Text(
              "Food Waste to Wealth",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Color(0xff4eb447),
              ),
            ),
            SizedBox(
              height: 30,
              width: 16,
            ),
            RichText(
              text: TextSpan(
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
            SizedBox(
              height: 38,
              width: 16,
            ),
            Align(
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
            SizedBox(
              height: 10,
              width: 16,
            ),
            MaterialButton(
              onPressed: () {
                _navigateToRegistrationScreen(context, "household");
                // Navigator.pushNamed(context, 'Register');
              },
              color: Color(0xff4eb447),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                "Household",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              textColor: Color(0xffffffff),
              height: 40,
              minWidth: 260,
            ),
            SizedBox(
              height: 10,
              width: 16,
            ),
            MaterialButton(
              onPressed: () {
                _navigateToRegistrationScreen(context, "business");
                // Navigator.pushNamed(context, 'Register');
              },
              color: Color(0xff4eb447),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                "Business",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              textColor: Color(0xffffffff),
              height: 10,
              minWidth: 260,
            ),
            SizedBox(
              height: 70,
              width: 16,
            ),
            Image(
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
