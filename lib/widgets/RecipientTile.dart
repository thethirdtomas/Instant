import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/FirestoreTask.dart';
import 'package:intl/intl.dart';

class RecipientTile extends StatelessWidget {
  final Map data;
  final Function(Map) onTap;
  RecipientTile({@required this.data, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    String recipientId = data['id'];
    String lastMessage = formatMessage(data['lastMessage']);
    String timeSent = formatTime(data['timeSent']);
    return FutureBuilder<Map>(
      future: FirestoreTask.findRecipientById(recipientId),
      builder: (context, snapshot) {
        Map recipient = snapshot.data;
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              onTap: () => onTap(recipient),
              title: Text(
                recipient['name'],
                style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat", fontSize: 20),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(lastMessage, style: TextStyle(color: Colors.white)),
              ),
              trailing: Text(timeSent,style: TextStyle(color: Colors.grey, fontSize: 12),),
              leading: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(recipient['profileImage']),
                  ),
                ),
              ),
            ),
          );
        }
        return Text(
          "error",
          style: TextStyle(color: Colors.white),
        );
      },
    );
  }

  String formatMessage(String message) {
    int limit  = 60;
    if (message.length > limit) {
      return message.substring(0, limit) + " ...";
    }
    return message;
  }

  String formatTime(Timestamp timestamp){
    return DateFormat("jm").format(timestamp.toDate());
  }
}
