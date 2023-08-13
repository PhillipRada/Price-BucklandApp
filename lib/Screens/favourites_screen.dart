import 'package:flutter/material.dart';
import 'package:practise1/Screens/IndexPage.dart';
import '../Components/favourites_body.dart';
import '../constants.dart';

class favouritescreen extends StatelessWidget {
  const favouritescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: buildAppBar(context),
      //Need To Figure A Way To Add Favourites
      body: Favourites(),
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
      onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => IndexPage())),
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
      SizedBox(
        width: DefaultPadding / 2,
      ),
    ],
  );
}
