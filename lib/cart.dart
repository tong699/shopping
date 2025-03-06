import 'package:flutter/material.dart';
import 'package:shopping/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopping/item.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CartListWidget(),
        ],
      ),
    );
  }
}

class CartListWidget extends StatefulWidget {
  const CartListWidget({super.key});

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child){
        return cart.itemList.isNotEmpty?
            ListView.separated(
              padding: EdgeInsets.all(8.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CartItem(item: cart.itemList[index]);
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider();
                },
                itemCount: cart.itemList.length,
            )
            : const Text('Cart is empty');
      }
    );
  }
}

class CartItem extends StatelessWidget {
  final Item item;

  const CartItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    //Retrieve an item from the catalog

    return Row(
      children: [
        //Text(item.toString()) same as below
        Text('$item'), //Call the toString method
        const Expanded(child: SizedBox()),
        Consumer<CartProvider>(builder: (context, cart, child) {
          return TextButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).remove(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item removed from cart.')
                  ),
                );
              },
              child: const Text('Remove'));
        }),
      ],
    );
  }
}