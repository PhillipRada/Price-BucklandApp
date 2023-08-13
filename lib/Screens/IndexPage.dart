import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practise1/Screens/Start_UpScreen.dart';
import 'package:practise1/constants.dart';
import 'package:practise1/utils/rive_utils.dart';
import 'package:rive/rive.dart';

import '../Components/animated_bar.dart';
import '../models/rive_asset.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  RiveAsset selectedBottomNav = bottomNavs.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const StartUpPage(),
      bottomNavigationBar: BottomRiveBar(context),
    );
  }

  Padding BottomRiveBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input!.change(true);

                    if (bottomNavs[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = bottomNavs[index];
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => bottomNavs[index].page),
                        );
                      });
                    }
                    Future.delayed(const Duration(seconds: 3), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive: bottomNavs[index] == selectedBottomNav,
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);
                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
