import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/products.dart';

class ProductTitlePriceImage extends StatelessWidget {
  const ProductTitlePriceImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: DefaultPadding, vertical: DefaultPadding / 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Best Clothing Around",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: DefaultPadding,
          ),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Price\n",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  TextSpan(
                    text: "\£${product.price}",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
              SizedBox(
                width: DefaultPadding,
              ),
              Expanded(
                  child: Image.asset(
                product.image,
                fit: BoxFit.fitWidth,
              ))
            ],
          )
        ],
      ),
    );
  }
}
