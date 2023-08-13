import 'package:flutter/material.dart';
import 'package:practise1/Screens/productDetails_screen.dart';

import '../constants.dart';
import '../models/products.dart';
import 'catergories_bar.dart';
import 'product_cards.dart';

class StartUpBody extends StatefulWidget {
  const StartUpBody({Key? key}) : super(key: key);

  @override
  _StartUpBodyState createState() => _StartUpBodyState();
}

class _StartUpBodyState extends State<StartUpBody> {
  // Define a variable to keep track of the selected category.
  // Initially set to "All".
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Show a heading for the shopping page.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
          child: Text(
            "Shopping Home Page",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        // Show a categories bar that allows users to filter products.
        Categories(
          onCategorySelected: (category) {
            setState(() {
              selectedCategory = category;
            });
          },
        ),
        // Show a grid of products based on the selected category.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
            child: GridView.builder(
              itemCount: selectedCategory == "All"
                  ? products.length
                  : products
                      .where((product) => product.category == selectedCategory)
                      .length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: DefaultPadding / 3,
                crossAxisSpacing: DefaultPadding,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                // Get the list of products based on the selected category.
                final filteredProducts = selectedCategory == "All"
                    ? products
                    : products
                        .where(
                            (product) => product.category == selectedCategory)
                        .toList();
                // Shows a product card for each product in the filtered list.
                // The card will display the product's image, name, and price.
                // When the card is tapped, navigate to the product details page.
                return ProductCard(
                  product: filteredProducts[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: filteredProducts[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
