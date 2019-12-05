import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final Map user;
  Profile({@required this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
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
                      child: Text(widget.user['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 33)),
                    ),
                  ],
                ),
                CachedNetworkImage(
                  imageUrl: widget.user['profileImage'],
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
            Text("@${widget.user['username']}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "${widget.user['bio']}",
                style: TextStyle(
                    color: Colors.green[100], fontFamily: "Montserrat"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
