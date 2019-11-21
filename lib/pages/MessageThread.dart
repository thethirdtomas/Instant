import 'package:flutter/material.dart';

class MessageThread extends StatefulWidget {
  final String recipientId;
  MessageThread({@required this.recipientId});
  @override
  _MessageThreadState createState() => _MessageThreadState();
}

class _MessageThreadState extends State<MessageThread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(widget.recipientId, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}