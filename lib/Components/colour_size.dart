import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../Screens/rating_screen.dart';
import '../models/products.dart';

class ColorandSize extends StatefulWidget {
  const ColorandSize({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  _ColorandSizeState createState() => _ColorandSizeState();
}

class _ColorandSizeState extends State<ColorandSize> {
  var rating = null;

  String _selectedSize = 'Small';

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Stars')
        .doc(widget.product.title)
        .collection('Ratings')
        .get()
        .then((value) {
      var ratings = 0.0;
      var total = 0;
      value.docs.forEach((element) {
        ratings += element.data()['rating'];
        total++;
      });
      ratings /= total;
      setState(() {
        rating = ratings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmoothStarRating(
                  allowHalfRating: true,
                  onRated: (v) {},
                  starCount: 5,
                  rating: rating,
                  size: 25.0,
                  isReadOnly: true,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.blue,
                  borderColor: Colors.black,
                  spacing: 0.0),
              Row(
                children: [
                  MaterialButton(
                    color: Colors.white,
                    textColor: Colors.black,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RatingScreen(product: widget.product)),
                      );
                    },
                    child: Text('Leave A Review'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedSize,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSize = newValue!;
                  });
                },
                items: <String>['Small', 'Medium', 'Large', 'X-Large']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
