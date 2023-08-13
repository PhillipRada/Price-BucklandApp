import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise1/Screens/IndexPage.dart';
import 'package:rive/rive.dart';

import '../Components/animated_btn.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RiveAnimation.asset(
            'assets/RiveAssets/welcome_animations.riv',
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          "Welcome To Price & Buckland",
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: "Poppins",
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text("We have recently launched our new app. "
                            "Here you can buy any amount of clothes that you need. "
                            "We have made it as simple and as easy as possible.")
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedBtn(
                    btnAnimationController: _btnAnimationController,
                    press: () {
                      _btnAnimationController.isActive = true;
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => IndexPage()));
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text("We have recently launched our new app. Here"
                        " you can buy any amount of clothes that you need. "
                        "We have made it as simple and as easy as possible."),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
