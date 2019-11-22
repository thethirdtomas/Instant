import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:instant/widgets/MessageBubble.dart';
import 'package:intl/intl.dart';

class MessageThread extends StatelessWidget {
  final List messages;
  MessageThread({@required this.messages});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            String message = messages[index].data['message'];
            String user = messages[index].data['user'];
            bool isUser = user == Auth.uid;
            Timestamp timestamp = messages[index].data['timeSent'];
            String time = DateFormat("jm").format(timestamp.toDate());
            return MessageBubble(isUser: isUser, message: message,time: time,);
          },
        ),
      ),
    );
  }
}
