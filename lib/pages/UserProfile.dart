import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/FirestoreStreams.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirestoreStreams.userStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(snapshot.data['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: 33)),
                        ),
                      ],
                    ),
                    CachedNetworkImage(
                      imageUrl: snapshot.data['profileImage'],
                      imageBuilder: (context, imageProvider) => Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
                Text("@${snapshot.data['username']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${snapshot.data['bio']}",
                      style: TextStyle(
                          color: Colors.green[100], fontFamily: "Montserrat")),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
