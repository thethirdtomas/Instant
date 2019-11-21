import 'package:flutter/material.dart';
import 'package:instant/pages/Proile.dart';

class MessageThread extends StatefulWidget {
  final Map recipient;
  MessageThread({@required this.recipient});
  @override
  _MessageThreadState createState() => _MessageThreadState();
}

class _MessageThreadState extends State<MessageThread> {
  TextEditingController message = TextEditingController();

  bool empty = true;
  checkEmpty(String msg){
    if(empty && msg != ''){
      setState(() {
        empty = false;
      });
    } else if(!empty && msg == ''){
      setState(() {
        empty = true;
      });
    }
  }

  sendMessage(){
    if(!empty){

    }
  }

  viewProfile(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>Profile(
          user: widget.recipient,
        )
      )
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
                          image: NetworkImage(
                              widget.recipient['profileImage']),),),
                ),
                Text(widget.recipient['name'], style: TextStyle(fontFamily: "Montserrat"),),
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
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: TextField(
                  controller: message,
                  onChanged: checkEmpty,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.tag_faces, color: Colors.grey,),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        color:empty?Colors.grey:Colors.white,
                        onPressed: sendMessage,
                      )),
                ),
              )
            ],
          )),
    );
  }
}
