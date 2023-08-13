import 'package:flutter/material.dart';

class Product {
  final String image, title, description, category; // add category property
  final int price, size, quantity, id;
  final Color color;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
    required this.quantity,
    required this.category, // add category property
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Cardigan",
      price: 28,
      size: 12,
      quantity: 12,
      description: dummyText,
      image: "assets/images/Cardigan 1.png",
      color: Color(0xFFE1E1E9),
      category: "Cardigans"), // add category property
  Product(
      id: 2,
      title: "Jumper",
      price: 35,
      size: 8,
      quantity: 12,
      description: dummyText,
      image: "assets/images/Jumper 1.png",
      color: Color(0xFFE1E1E9),
      category: "Jumpers"), // add category property
  Product(
      id: 3,
      title: "PE-Shirt",
      price: 17,
      size: 10,
      quantity: 12,
      description: dummyText,
      image: "assets/images/PE-Shirt1.png",
      color: Color(0xFFE1E1E9),
      category: "PE"), // add category property
  Product(
      id: 4,
      title: "Shoes",
      price: 20,
      size: 11,
      quantity: 12,
      description: dummyText,
      image: "assets/images/Shoes1.png",
      color: Color(0xFFE1E1E9),
      category: "Shoes"), // add category property
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
