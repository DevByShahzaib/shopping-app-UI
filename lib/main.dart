import 'package:cart/cart_provider.dart';
import 'package:cart/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue
          ),
          debugShowCheckedModeBanner: false,
          home: ProductListScreen(),
        );
      }),
    );
  }
}
