import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../constants.dart';
import '../models/products.dart';

class RatingScreen extends StatefulWidget {
  RatingScreen({
    super.key,
    required this.product,
  });

  final user = FirebaseAuth.instance.currentUser;
  final Product product;

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  String _rating = '';

  void uploadRating() {
    FirebaseFirestore.instance
        .collection('Stars')
        .doc(widget.product.title)
        .collection('Ratings')
        .doc(widget.user?.email)
        .set({'rating': userrating, 'ratingInfo': _RatingController.text});
  }

  @override
  var rating = null;
  var userrating = 0.0;
  TextEditingController _RatingController = TextEditingController();

  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: Image.asset(
                widget.product.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${widget.product.price}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Column(
                children: [
                  Text('Current rating',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                ],
              ),
            ]),
            SizedBox(height: 15),
            Column(
              children: [
                Text('Click To Change Rating',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SmoothStarRating(
                    allowHalfRating: true,
                    onRated: (v) {
                      setState(() {
                        userrating = v;
                      });
                    },
                    starCount: 5,
                    rating: userrating,
                    size: 25.0,
                    isReadOnly: false,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    color: Colors.blue,
                    borderColor: Colors.black,
                    spacing: 0.0),
              ],
            ),
            Form(
              child: TextFormField(
                controller: _RatingController,
                maxLength: 250,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a rating';
                  }
                  return null;
                },
                onSaved: (value) => _rating = value!,
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.check),
              onPressed: () {
                uploadRating();
                // TODO: Submit the review. This button needs to send review data to firebase and have it stored there
              },
            ),
          ],
        ),
      ),
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
      onPressed: () => Navigator.pop(context),
    ),
    title: Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Image.asset(
        "assets/logo/Group 36.png",
        height: 35,
      ),
    ),
  );
}
