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
          reverse: true,
          shrinkWrap: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            if (messages[index] is String) {
              print(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  messages[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 33
                  ),
                ),
              );
            } else {
              String message = messages[index].data['message'];
              String user = messages[index].data['user'];
              bool isUser = user == Auth.uid;
              Timestamp timestamp = messages[index].data['timeSent'];
              String time = DateFormat("jm").format(timestamp.toDate());
              return MessageBubble(
                isUser: isUser,
                message: message,
                time: time,
              );
            }
          },
        ),
      ),
    );
  }
 
}
