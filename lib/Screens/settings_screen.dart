import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise1/Screens/login_screen.dart';
import '../constants.dart';
import 'IndexPage.dart';
import 'cart_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          buildListTile(
            icon: Icons.accessible_sharp,
            title: 'Accessability',
            onTap: () {},
          ),
          buildListTile(
            icon: Icons.back_hand,
            title: 'Privacy and Security',
            onTap: () {},
          ),
          buildListTile(
            icon: Icons.settings,
            title: 'General',
            onTap: () {},
          ),
          buildListTile(
            icon: Icons.notification_add,
            title: 'Notification',
            onTap: () {},
          ),
          buildListTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();

              // Navigate to the login screen and remove all previous routes
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
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
        icon: Image.asset(
          "assets/Icons/loupe.png",
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Image.asset(
          "assets/Icons/shopping-cart.png",
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
      ),
      SizedBox(
        width: DefaultPadding / 2,
      )
    ],
  );
}
