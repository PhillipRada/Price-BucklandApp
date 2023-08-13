import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartPdt extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String name;

  CartPdt(this.id, this.productId, this.price, this.quantity, this.name);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.white,
        child: Icon(Icons.remove_circle_outlined, color: Colors.red, size: 48),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(name),
          subtitle: Text('Total: \$${(price * quantity)}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
