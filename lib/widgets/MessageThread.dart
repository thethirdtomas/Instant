import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/Auth.dart';
import 'package:instant/widgets/MessageBubble.dart';
import 'package:intl/intl.dart';

class MessageThread extends StatefulWidget {
  final List messages;
  MessageThread({@required this.messages});
  @override
  _MessageThreadState createState() => _MessageThreadState();
}

class _MessageThreadState extends State<MessageThread> {
  List tfm;

  @override
  void initState() {
    super.initState();
    tfm = timeFormatedMessages(widget.messages);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: tfm.length,
          itemBuilder: (context, index) {
            if (tfm[index] is String) {
              print(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tfm[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 33
                  ),
                ),
              );
            } else {
              String message = tfm[index].data['message'];
              String user = tfm[index].data['user'];
              bool isUser = user == Auth.uid;
              Timestamp timestamp = tfm[index].data['timeSent'];
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

  List timeFormatedMessages(List messages) {
    DateTime currentDay = messages[0].data['timeSent'].toDate();
    List tfm = [];
    tfm.add(messages[0]);

    for (int i = 1; i < messages.length; i++) {
      DateTime timeSent = messages[i].data['timeSent'].toDate();
      if(DateFormat('yMd').format(timeSent) != DateFormat('yMd').format(currentDay)){
        tfm.add(formatTime(currentDay));
        currentDay = timeSent;
      }
      tfm.add(messages[i]);
    }
    tfm.add(formatTime(currentDay));
    return tfm;
  }

  String formatTime(DateTime dt){
    DateTime oneDayAgo = DateTime.now().subtract(Duration(days: 1));
    DateTime twoDaysAgo = DateTime.now().subtract(Duration(days: 2));
    DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
    DateTime oneYearAgo = DateTime.now().subtract(Duration(days: 365));
    
    if(dt.isBefore(oneYearAgo)){
      return DateFormat('yMd').format(dt);
    }
    if(dt.isBefore(oneWeekAgo)){
      return DateFormat('MMMd').format(dt);
    }else if(dt.isBefore(twoDaysAgo) || DateFormat('yMd').format(dt) == DateFormat('yMd').format(twoDaysAgo)){
      return DateFormat('EEEE').format(dt);
    }else if(DateFormat('yMd').format(dt) == DateFormat('yMd').format(oneDayAgo)){
      return "Yesterday";
    }
    return "Today";
  }
}
