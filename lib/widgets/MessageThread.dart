import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:instant/utilities/FirestoreTask.dart';
import 'package:instant/widgets/MessageBubble.dart';
import 'package:intl/intl.dart';

class MessageThread extends StatelessWidget {
  final List messages;
  final String compositeId;
  MessageThread({@required this.messages, this.compositeId});

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
              String messageId = messages[index].documentID;
              String message = messages[index].data['message'];
              String user = messages[index].data['user'];
              bool read = messages[index].data['read'];
              bool isUser = user == Auth.uid;
              Timestamp timestamp = messages[index].data['timeSent'];
              String time = DateFormat("jm").format(timestamp.toDate());

              if(!read && !isUser){
                FirestoreTask.markMessageAsRead(compositeId, messageId);
              }
              return MessageBubble(
                isUser: isUser,
                message: message,
                time: time,
                read: read,
              );
            }
          },
        ),
      ),
    );
  }
 
}
