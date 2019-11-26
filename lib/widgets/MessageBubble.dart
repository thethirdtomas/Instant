import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isUser, read;
  final String message, time;
  MessageBubble(
      {@required this.message,
      @required this.time,
      @required this.isUser,
      @required this.read});
  @override
  Widget build(BuildContext context) {
    final bg = isUser ? Colors.green[300] : Colors.green[100];
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isUser
        ? BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 60.0),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 10.0,
                      ),
                    ),
                    isUser
                        ? Icon(
                            read?Icons.done_all:Icons.done,
                            size: 12.0,
                            color: Colors.black38,
                          )
                        : Text(""),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
