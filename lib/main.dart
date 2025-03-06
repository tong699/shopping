import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/cart.dart';
import 'package:shopping/cart_provider.dart';

import 'item.dart';

final List<Item> catalog = [
  Item(1, 'Shoes'),
  Item(2, 'Hats'),
  Item(3, 'Shirts'),
  Item(4, 'Tie'),
  Item(5, 'Pants'),
  Item(6, 'Jeans'),
  Item(7, 'Shorts'),
  Item(8, 'Underwear'),
  Item(9, 'Jumpers'),
  Item(10, 'Trousers'),
  Item(11, 'Sleepwear'),
  Item(12, 'Accessories'),
];

void main() {
  runApp(
      //Associate the CartProvider as a state manager to the MyApp
      ChangeNotifierProvider(
          create: (context) => CartProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context)=> const Cart()
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index){
            return CartItem(index: index);
            },
            separatorBuilder: (BuildContext context, int index){
              return const Divider();
          },
            itemCount: catalog.length
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final int index;

  const CartItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    //Retrieve an item from the catalog
    var item = catalog[index];

    return Row(
      children: [
        //Text(item.toString()) same as below
        Text('$item'), //Call the toString method
        const Expanded(child: SizedBox()),
        Consumer<CartProvider>(builder: (context, cart, child) {
          return TextButton(
              onPressed: () {
                cart.add(item);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item added to cart.')
                  ),
                );
              },
              child: const Text('Add'));
        }),
      ],
    );
  }
}
