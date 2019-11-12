import 'package:flutter/material.dart';
import 'package:instant/pages/EnterPhone.dart';
import 'package:instant/widgets/WelcomeBanner.dart';
import 'package:instant/widgets/GradiantButton.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WelcomeBanner(),
            GradiantButton(
              text: "Start Messaging",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EnterPhone()));
              },
            )
          ],
        ),
      ),
    );
  }
}
