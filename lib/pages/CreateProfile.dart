import 'package:flutter/material.dart';
import 'package:instant/widgets/GradiantButton.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Your Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 33)),
            ),
            GradiantButton(
              text: "Create Profile",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
