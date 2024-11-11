import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_chat/screens/chatscreen/components/messagebubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resources/constants.dart';
import 'components/messagesendingtile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var loggedIn;
  final TextEditingController _message = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    var currentUser = _auth.currentUser;
    if (currentUser != null) {
      loggedIn = currentUser.email;
      if (kDebugMode) {
        print("$loggedIn");
      }
    }
  }

  void signOut() {
    _auth.signOut();
    Navigator.pop(context);
  }

  Future sendMessage() async {
    try {
      await _fireStore.collection("messages").add({
        "sender": loggedIn,
        "text": _message.text,
        "timestamp": FieldValue.serverTimestamp(),
      });
      _message.text = "";
      FocusScope.of(context).unfocus(); //it will close the keypad
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
                //Implement logout functionality
                signOut();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection("messages")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;

                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height / 1.2,
                    child: ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var sms = messages[index]["text"];
                          var sender = messages[index]["sender"];
                          var messageId = messages[index].id;

                          return MessageBubbles(
                            isMe: loggedIn == sender,
                            sender: sender,
                            sms: sms,
                          );
                        }),
                  );
                }),
            MessageSendingTile(
              controller: _message,
              onPressed: () {
                sendMessage();
              },
            )
          ],
        ),
      ),
    );
  }
}
