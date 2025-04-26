import 'package:flutter/material.dart';
import 'package:notifycart/viewmodel/cart.dart';
import 'package:notifycart/viewmodel/stock.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartViewModel cart = context.watch<CartViewModel>();
    Map pizzas = context.watch<StockViewModel>().data as Map;

    // Soo we can do this here
    double fullPrice = 0;
    for (var product in cart.content) {
      fullPrice += pizzas[product];
    }

    return Scaffold(
      // Why there is no back button in go_router stateful shell route :(
      appBar: AppBar(title: Text('Your cart'), centerTitle: true),
      body:
          cart.isEmpty
              ? Center(
                child: Text(
                  'Cart is empty',
                  style: TextStyle(color: Colors.black38),
                ),
              )
              : Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            String currentPizza = cart.content[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                spacing: 10,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      currentPizza,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '\$${pizzas[currentPizza].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      cart.remove(currentPizza);
                                    },
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: cart.length,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        child: Text(
                          'Buy for \$${fullPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
    );
  }
}
