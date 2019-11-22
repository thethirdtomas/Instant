import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/pages/Chat.dart';
import 'package:instant/pages/NewMessage.dart';
import 'package:instant/utilities/FirestoreStreams.dart';
import 'package:instant/widgets/RecipientTile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  newMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewMessage()),
    );
  }

  viewChat(Map recipient) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>Chat(recipient: recipient,))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instant", style: TextStyle(fontFamily: 'Pacifico')),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: newMessage,
        child: Icon(Icons.message),
      ),
      body: Container(
          color: Colors.black,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreStreams.recipientsStream(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                List recipients = snapshots.data.documents;
                return ListView.builder(
                  itemCount: recipients.length,
                  itemBuilder: (context, index) {
                    Map recipientData = recipients[index].data;
                    recipientData['id'] = recipients[index].documentID;
                    return RecipientTile(
                      data: recipientData,
                      onTap: viewChat,
                    );
                  },
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.green[300],
              ));
            },
          )),
    );
  }
}
