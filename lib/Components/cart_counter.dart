import 'package:flutter/material.dart';

import '../constants.dart'; // import constants.dart file

class CartCount extends StatefulWidget {
  const CartCount({Key? key}) : super(key: key);

  @override
  State<CartCount> createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  int numOfItems = 1; // initialize the number of items to 1

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // build the "remove" button
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              // decrement the number of items if it's greater than 1
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DefaultPadding / 2),
          child: Text(
            numOfItems
                .toString()
                .padLeft(2, "0"), // display the number of items
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // build the "add" button
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              if (numOfItems < 12) {
                // increment the number of items if it's less than 12
                setState(() {
                  numOfItems++;
                });
              }
            })
      ],
    );
  }

  // function to build the outline button
  SizedBox buildOutlineButton(
      {required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        onPressed: press,
        child: Icon(icon), // display the icon passed to the function
      ),
    );
  }
}
