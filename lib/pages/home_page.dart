import 'package:notifycart/pages/order_page.dart';
import 'package:flutter/material.dart';
import 'package:notifycart/viewmodel/cart.dart';
import 'package:notifycart/viewmodel/stock.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var stock = context.watch<StockViewModel>();
    var cart = context.watch<CartViewModel>();

    if (stock.data == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  // lol
                  (_) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(
                        value: context.watch<StockViewModel>(),
                      ),
                      ChangeNotifierProvider.value(
                        value: context.watch<CartViewModel>(),
                      ),
                    ],

                    child: OrderPage(),
                  ),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
      appBar: AppBar(title: Text('Pizza'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              cart.isEmpty
                  ? 'Your cart is empty'
                  : 'Cart items count: ${cart.length}',
              style: TextStyle(fontSize: 18),
            ),
            Divider(),
            Expanded(
              child: GridView.builder(
                itemCount: stock.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder:
                    (context, index) => buildPizzaCard(
                      context,
                      context.watch<CartViewModel>(),
                      index,
                      stock.data as Map,
                      cart.content,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPizzaCard(context, vm, index, Map pizzas, List cart) {
    String currentPizza = pizzas.keys.toList()[index];
    double price = pizzas[currentPizza];

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (cart.contains(currentPizza)) {
          // Remove
          vm.remove(currentPizza);
          return;
        }

        // Add
        vm.add(currentPizza);
      },
      child: Card(
        color: cart.contains(currentPizza) ? Colors.white70 : Colors.white,

        elevation: !cart.contains(currentPizza) ? 5 : 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                currentPizza,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Expanded(child: Icon(Icons.local_pizza, size: 80)),
              Divider(endIndent: 10, indent: 10),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                    !cart.contains(currentPizza)
                        ? // Add to cart
                        Text(
                          '\$${price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                        : // Remove from cart
                        Text(
                          'Remove',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
