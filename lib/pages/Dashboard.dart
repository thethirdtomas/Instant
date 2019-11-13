import 'package:flutter/material.dart';
import 'package:instant/utilities/Auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
            child: Text(
          Auth.uid,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
