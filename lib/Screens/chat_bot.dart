import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:practise1/Screens/IndexPage.dart';

import '../constants.dart';
import 'cart_screen.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  dynamic conversationObject = {
    'appId': '291abb0230aa8d906d8bffc37e7649861',
    'userId': "",
  };

  @override
  final user = FirebaseAuth.instance.currentUser;

  void initState() {
    conversationObject['userId'] = '${user?.email}';
    KommunicateFlutterPlugin.buildConversation(conversationObject)
        .then((clientConversationId) {
      print(
          "Conversation builder success : " + clientConversationId.toString());
    }).catchError((error) {
      print("Conversation builder error : " + error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF253955),
    elevation: 0,
    leading: IconButton(
      icon: Image.asset(
        "assets/Icons/back.png",
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndexPage()),
        );
      },
    ),
    title: Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Image.asset(
        "assets/logo/Group 36.png",
        height: 35,
      ),
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Image.asset(
          "assets/Icons/loupe.png",
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        icon: Image.asset(
          "assets/Icons/shopping-cart.png",
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: DefaultPadding / 2,
      ),
    ],
  );
}
