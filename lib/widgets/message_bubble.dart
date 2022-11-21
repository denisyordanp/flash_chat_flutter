import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Material(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMe ? 30 : 0),
                    topRight: const Radius.circular(30),
                    bottomLeft: const Radius.circular(30),
                    bottomRight: Radius.circular(isMe ? 0 : 30)),
                elevation: 3,
                color: isMe ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    text,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 15),
                  ),
                ),
              )
            ]));
  }
}
