import './cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;

  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://priceandbuckland-ef905-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'id': DateTime.now().toString(),
            'amount': total,
            'dateTime': timestamp.toString(),
            'products': cartProducts
                .map((cartprod) => {
                      'id': cartprod.id,
                      'title': cartprod.name,
                      'quantity': cartprod.quantity,
                      'price': cartprod.price,
                    })
                .toList(),
          },
        ),
      );
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              dateTime: timestamp,
              products: cartProducts));
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
