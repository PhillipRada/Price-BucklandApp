import 'package:flutter/material.dart';

import '../constants.dart';

class Categories extends StatefulWidget {
  final ValueChanged<String>
      onCategorySelected; // add onCategorySelected callback

  const Categories({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "All", // add "All" category
    "Shoes",
    "Jumpers",
    "Cardigans",
    "Ties",
    "PE",
    "Blazers"
  ];
  int selectedIndex = 0; // set default selected index to 0 for "All" category

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        widget.onCategorySelected(
            categories[index]); // call onCategorySelected callback
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? Colors.black : Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: DefaultPadding / 5),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
