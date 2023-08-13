import 'package:flutter/material.dart';
import 'package:practise1/Components/product_detailsbody.dart';
import 'package:practise1/Screens/cart_screen.dart';
import 'package:practise1/constants.dart';

import '../models/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: product.color,
        appBar: buildAppBar(context),
        body: ProductBody(
          product: product,
        ));
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
        onPressed: () => Navigator.pop(context),
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
}
