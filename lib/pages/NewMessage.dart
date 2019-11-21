import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:instant/utilities/FirestoreTask.dart';
import 'package:instant/widgets/GradiantButton.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController username = TextEditingController();
  bool loading = false;
  bool error = false;

  message() async{
    setState(() {
      loading = true;
    });

    String recipientId = await FirestoreTask.findIdByUsername(username.text);
    if(recipientId == null){
      error = true;
    }else{
      error = false;
      print(recipientId);
      //navigate to message thread
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
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
                  child: Text("New Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 33)),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: username,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "username",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.error_outline,
                          color: error ? Colors.redAccent : Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "In order to message on Insant a recipients username is needed.",
                    style: TextStyle(
                        color: Colors.green[100], fontFamily: "Montserrat"),
                  ),
                ),
              ],
            ),
            loading
                ? SpinKitWave(color: Colors.white, size: 30.0)
                : GradiantButton(
                    onTap: message,
                    text: "Message",
                  )
          ],
        ),
      ),
    );
  }
}
