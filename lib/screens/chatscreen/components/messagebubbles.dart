import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  MessageBubbles({this.isMe,this.sender,this.sms});
  bool? isMe;
  String? sender;
  String? sms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: isMe == true
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender.toString(),
            style: const TextStyle(
                color: Colors.grey, fontSize: 10),
          ),
          const SizedBox(
            height: 5,
          ),
          isMe != true
              ? Container(
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight:
                      Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(sms.toString()),
              ))
              : Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(sms.toString()),
              ),
              decoration: const BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight:
                      Radius.circular(10)))),
        ],
      ),
    );
  }
}