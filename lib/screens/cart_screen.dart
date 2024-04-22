import 'package:doggie_shop/utilities/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartScreen extends StatelessWidget {
  final List<String>? cartItems = LocalStorageService.getCartItems();

  CartScreen() {
    // Clear cart on hot restart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalStorageService.clearCart();
    });
  }

  int _calculateTotalPrice() {
    return cartItems!.length * 100; // You can update this logic as per your requirement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: cartItems!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Image.network(
              cartItems![index],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total: \$${_calculateTotalPrice()}', style: TextStyle(fontSize: 25),),
                  GestureDetector(
                    onTap: () {
                      // Clear the cart
                      LocalStorageService.clearCart();
                      // You can add animation here
                    },
                    child: Text('Clear Cart'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Success'),
                      content: Text('Checkout successful!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Checkout'),
              ),
            ),
          ],
        ),
      ),


    );
  }
}
