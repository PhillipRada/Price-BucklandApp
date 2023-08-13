import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/products.dart';

class Desc extends StatelessWidget {
  const Desc({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: Text(product.description, style: TextStyle(height: 1.5)),
    );
  }
}
