import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Map user;
  Profile({@required this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(widget.user['bio'],style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}