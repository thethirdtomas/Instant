import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/FirestoreTask.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontSize: 20),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(lastMessage, style: TextStyle(color: Colors.white)),
              ),
              trailing: Text(
                timeSent,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              leading: CachedNetworkImage(
                imageUrl: recipient['profileImage'],
                imageBuilder: (context, imageProvider) => Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          );
        }
        return Text("");
      },
    );
  }

  String formatMessage(String message) {
    int limit = 60;
    if (message.length > limit) {
      return message.substring(0, limit) + " ...";
    }
    return message;
  }

  String formatTime(Timestamp timestamp) {
    DateTime dt = timestamp.toDate();
    DateTime oneDayAgo = DateTime.now().subtract(Duration(days: 1));
    DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: 365));

    if (dt.isBefore(oneYearAgo)) {
      return DateFormat('yMd').format(dt);
    }
    if (dt.isBefore(oneWeekAgo)) {
      return DateFormat('MMMd').format(dt);
    } else if (dt.isBefore(oneDayAgo)) {
      return DateFormat('E').format(dt);
    }
    return DateFormat("jm").format(dt);
  }
}
