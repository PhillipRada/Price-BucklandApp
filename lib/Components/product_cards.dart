import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/products.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? press;

  const ProductCard({
    super.key,
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(DefaultPadding),
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(product.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DefaultPadding / 4),
            child: Text(
              product.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            "\£${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
