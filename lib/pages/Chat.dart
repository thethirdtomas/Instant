import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/pages/Proile.dart';
import 'package:instant/utilities/FirestoreStreams.dart';
import 'package:instant/utilities/FirestoreTask.dart';
import 'package:instant/widgets/MessageThread.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  final Map recipient;
  Chat({@required this.recipient});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController message = TextEditingController();

  bool empty = true;
  checkEmpty(String msg) {
    if (empty && msg != '') {
      setState(() {
        empty = false;
      });
    } else if (!empty && msg == '') {
      setState(() {
        empty = true;
      });
    }
  }

  sendMessage() {
    if (!empty) {
      FirestoreTask.sendMessage(
          recipientId: widget.recipient['id'], message: message.text);
      setState(() {
        message.clear();
        empty = true;
      });
    }
  }

  viewProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(
          user: widget.recipient,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: GestureDetector(
          onTap: viewProfile,
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.recipient['profileImage']),
                    ),
                  ),
                ),
                Text(
                  widget.recipient['name'],
                  style: TextStyle(fontFamily: "Montserrat"),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirestoreStreams.messagesStream(
                    FirestoreTask.getCompositeId(widget.recipient['id'])),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    List messages = timeFormatedMessages(snapshots.data.documents);
                    return MessageThread(messages: messages);
                  }
                  return Text("");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                child: TextField(
                  controller: message,
                  onChanged: checkEmpty,
                  style: TextStyle(color: Colors.white),
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.tag_faces,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        color: empty ? Colors.grey : Colors.white,
                        onPressed: sendMessage,
                      )),
                ),
              )
            ],
          )),
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
