import 'package:flutter/material.dart';
import 'package:instant/utilities/Auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Message", style:TextStyle(fontFamily: 'Montserrat')),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
