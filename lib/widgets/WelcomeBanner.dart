import 'package:flutter/material.dart';

class WelcomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 130,
            height: 130,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 15),
                  height: 50,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.white,
                          thickness: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 25),
                        child: Divider(
                          color: Colors.white,
                          thickness: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 50,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.white,
                          thickness: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 25),
                        child: Divider(
                          color: Colors.white,
                          thickness: 5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Instant",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Pacifico', fontSize: 33),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 75, right: 75),
          child: Text(
            "The World's fastest instant messaging app. It's free, secure, and powered by Google!",
            style: TextStyle(color: Colors.green[100], fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
