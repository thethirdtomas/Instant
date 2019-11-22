import 'package:flutter/material.dart';
import 'package:instant/pages/Dashboard.dart';
import 'package:instant/pages/Welcome.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, prefs) {
        if (prefs.hasData) {
          Widget page;
          if (prefs.data.containsKey('uid')) {
            Auth.uid = prefs.data.get('uid');
            page = Dashboard();
          } else {
            page = Welcome();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: page,
          );
        }
        return Container(
          color: Colors.black,
        );
      },
    );
  }
}
