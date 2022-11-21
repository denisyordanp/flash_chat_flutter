import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/schemas/Message.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = "chat_screen";

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? loggedInUser;

  String? messageText;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    try {
      loggedInUser = _auth.currentUser;
    } catch (e) {
      print(e);
      _popBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                _popBack();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: MessageStreamer(currentEmail: loggedInUser?.email)),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _firestore.collection('messages').add(Message(
                                text: messageText,
                                sender: loggedInUser?.email ?? "")
                            .toMap());
                        controller.clear();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _popBack() {
    Navigator.pop(context);
  }
}

class MessageStreamer extends StatelessWidget {
  MessageStreamer({
    super.key,
    required this.currentEmail,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? currentEmail;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent),
          );
        }
        return ListView(
          reverse: true,
          children: generateBubble(snapshot, currentEmail),
        );
      },
    );
  }

  List<MessageBubble> generateBubble(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      String? currentEmail) {
    return snapshot.data?.docs.reversed
            .map((message) => Message(
                text: message.data()['text'],
                sender: message.data()['sender'],
                time: int.parse(message.data()['time'])))
            .map((message) => MessageBubble(
                text: message.text,
                sender: message.sender,
                isMe: message.sender == currentEmail))
            .toList() ??
        List.empty();
  }
}
