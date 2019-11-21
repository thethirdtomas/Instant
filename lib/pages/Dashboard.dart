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
      appBar: AppBar(
        title: Text("Instant", style:TextStyle(fontFamily: 'Montserrat')),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: ()=>{},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: (){},
        child: Icon(Icons.message),
      ),
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
