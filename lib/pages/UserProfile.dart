import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instant/utilities/FirestoreStreams.dart';
import 'package:instant/utilities/FirestoreTask.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode bioFocus = FocusNode();

  updateName() {
    FirestoreTask.updateName(name.text);
    nameFocus.unfocus();
  }

  updateBio(){
    FirestoreTask.updatebio(bio.text);
    bioFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirestoreStreams.userStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              name.text = snapshot.data['name'];
              name.selection = TextSelection.fromPosition(
                  TextPosition(offset: name.text.length));
              bio.text = snapshot.data['bio'];
              bio.selection = TextSelection.fromPosition(
                  TextPosition(offset: bio.text.length));
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                focusNode: nameFocus,
                                onEditingComplete: updateName,
                                controller: name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontSize: 33),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
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
                  Text(
                    "@${snapshot.data['username']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      focusNode: bioFocus,
                      onEditingComplete: updateBio,
                      maxLength: 200,
                      minLines: 1,
                      maxLines: 5,
                      controller: bio,
                      style: TextStyle(
                          color: Colors.green[100], fontFamily: "Montserrat"),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
