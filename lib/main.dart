import 'package:flutter/material.dart';

//Screens Imports
import 'package:practise1/Screens/login_screen.dart';
import 'package:practise1/models/orders.dart';
import 'package:provider/provider.dart';

import 'Screens/cart_screen.dart';
import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
