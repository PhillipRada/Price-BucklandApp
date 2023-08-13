import 'package:flutter/material.dart';
import 'package:practise1/Components/Start_Up_Body.dart';
import 'package:practise1/constants.dart';

import 'cart_screen.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  State<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: StartUpBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF253955),
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/Icons/back.png",
          color: Colors.transparent,
        ),
        onPressed: () {},
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
}
