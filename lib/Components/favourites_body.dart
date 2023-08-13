import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screens/productDetails_screen.dart';
import '../models/products.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Favourites')
            .doc(FirebaseAuth.instance.currentUser?.email)
            .collection('fav')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 100, left: 16),
                child: Center(
                  child: Image.asset("assets/images/favriouteempty.png"),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance
                        .collection('Favourites')
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .collection('fav')
                        .doc(snapshot.data!.docs[index].id)
                        .delete();
                  },
                  background: Container(
                    color: Colors.red,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                    product: products[index],
                                  )));
                    },
                    child: ListTile(
                      title: Text(
                        snapshot.data?.docs[index]['title'],
                        style: TextStyle(fontSize: 50),
                      ),
                      leading: Image.asset(
                        snapshot.data?.docs[index]['image'],
                        fit: BoxFit.cover,
                        width: 150,
                        height: 300,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
