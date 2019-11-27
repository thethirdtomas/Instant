import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instant/pages/Dashboard.dart';
import 'package:instant/pages/Welcome.dart';
import 'package:instant/utilities/Auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, user) {
        Widget page;
        if (user.hasData) {
          Auth.uid = user.data.uid;
          page = Dashboard();
        } else {
          page = Welcome();
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: page,
        );
      },
    );
  }
}
