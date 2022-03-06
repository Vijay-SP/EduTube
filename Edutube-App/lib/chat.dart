// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:edutube/constraints.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/theme.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
get user1 => _auth.currentUser;
// var loggedInUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextEditingController = TextEditingController();
  String? messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          AppLocalizations.of(context)!.diss,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreambuilderClass(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextEditingController.clear();
                      FirebaseFirestore.instance.collection('messages').add(
                        {
                          'sender': user1.email,
                          'text': messageText,
                          'time': FieldValue.serverTimestamp() //add this
                        },
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
}

class StreambuilderClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('time', descending: false) //add this
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: CustomAppTheme.nearlyYoutubeRed,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageTime = message['time'] as Timestamp; //add this
          final currentUser = user1.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            time: messageTime, //add this
          );

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time; // add this

  MessageBubble(
      {required this.text,
      required this.sender,
      required this.isMe,
      required this.time}); //add the variable  in this constructor
  @override
  Widget build(BuildContext context) {
    var name = sender.split('@')[0];
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' $name', // add this only if you want to show the time along with the email. If you dont want this then don't add this DateTime thing
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            color: isMe
                ? CustomAppTheme.nearlyYoutubeRed
                : CustomAppTheme.nearlyWhite,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: isMe
                      ? CustomAppTheme.nearlyWhite
                      : CustomAppTheme.nearlyBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
