import 'package:flutter/material.dart';

import 'package:practise1/models/cart.dart';
import 'package:provider/provider.dart';
import '../components/cart_item.dart';

import '../constants.dart';
import '../models/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          cart.items.length == 0
              ? Padding(
                  padding: EdgeInsets.only(top: 200.0, left: 45, bottom: 230),
                  child: Image.asset('assets/images/cartempty.png'),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) => CartPdt(
                        cart.items.values.toList()[i].id,
                        cart.items.keys.toList()[i],
                        cart.items.values.toList()[i].price,
                        cart.items.values.toList()[i].quantity,
                        cart.items.values.toList()[i].name),
                  ),
                ),
          CheckoutButton(
            cart: cart,
          )
        ],
      ),
    );
  }
}

class CheckoutButton extends StatefulWidget {
  final Cart cart;

  const CheckoutButton({Key? key, required this.cart}) : super(key: key);

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Checkout'),
      onPressed: widget.cart.totalAmount <= 0
          ? null
          : () async {
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              widget.cart.clear();
            },
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
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Image.asset(
          "assets/Icons/loupe.png",
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: DefaultPadding / 2,
      ),
    ],
  );
}
