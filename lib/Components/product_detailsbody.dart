import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practise1/Components/productImage_Pricebodyinfo.dart';
import 'package:practise1/Components/product_desc.dart';
import 'package:practise1/constants.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/products.dart';
import 'cart_counter.dart';
import 'colour_size.dart';

class ProductBody extends StatelessWidget {
  final Product product;

  const ProductBody({super.key, required this.product});

  void uploadFavourite() async {
    final user = FirebaseAuth.instance.currentUser;
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Favourites')
        .doc(user!.email)
        .get();
    if (!docSnapshot.exists) {
      await FirebaseFirestore.instance
          .collection('Favourites')
          .doc(user.email)
          .set({});
    }
    await FirebaseFirestore.instance
        .collection('Favourites')
        .doc(user.email)
        .collection('fav')
        .add({
      'title': product.title,
      'image': product.image,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: DefaultPadding,
                    right: DefaultPadding,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorandSize(product: product),
                      Desc(product: product),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CartCount(),
                          Row(
                            children: <Widget>[
                              //Add to Shopping Cart Button
                              Container(
                                height: 50,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF6464),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.shopping_cart),
                                  color: Colors.black,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text('Added To Cart'),
                                      ),
                                    );
                                    cart.addItem(
                                        product.id.toString(),
                                        product.title,
                                        product.price.toDouble());
                                  },
                                ),
                              ),
                              // Favourite Button
                              Container(
                                height: 50,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00FFC2),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.favorite),
                                  color: Colors.red,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        content: Text('Added To Favorites'),
                                      ),
                                    );
                                    uploadFavourite();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                double height = 0;
                                double weight = 0;
                                double waistSize = 0;
                                String? sizeRecommendation = null;
                                return AlertDialog(
                                  title: Text('Enter your measurements'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Height (cm)',
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          height = double.tryParse(value)! /
                                              100; // convert to meters
                                        },
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Weight (kg)',
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          weight = double.tryParse(value)!;
                                        },
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Waist size (in)',
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          waistSize = double.tryParse(value)! *
                                              2.54; // convert to cm
                                        },
                                      ),
                                      if (sizeRecommendation != null)
                                        Text(
                                          'Recommended size: $sizeRecommendation',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        // Calculate size recommendation based on entered measurements
                                        double heightInMeters = height;
                                        double waistInMeters = waistSize /
                                            100; // convert to meters
                                        double size =
                                            (waistInMeters / heightInMeters) *
                                                100;

                                        if (size < 20) {
                                          sizeRecommendation = 'Small';
                                        } else if (size < 23) {
                                          sizeRecommendation = 'Medium';
                                        } else if (size < 26) {
                                          sizeRecommendation = 'Large';
                                        } else {
                                          sizeRecommendation = 'X-Large';
                                        }

                                        // Update the dialog to show the size recommendation
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  Text('Size recommendation'),
                                              content: Text(
                                                'Recommended size: $sizeRecommendation',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(color: Colors.black),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Size Test'),
                        ),
                      )
                    ],
                  ),
                ),
                ProductTitlePriceImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
