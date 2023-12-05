import 'package:cart/cart_model.dart';
import 'package:cart/cart_screen.dart';
import 'package:cart/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = ['Mango','Orange','Grapes', 'Banana', 'Cherry','Peach', 'Mixed Fruit Basket'];
  List<String> productUnit = ['KG','Dozen','KG','Dozen','KG','KG','KG'];
  List<int> productPrice = [10,20,30,40,50,60,70];
  List<String> productImages = [
    'https://www.freepnglogos.com/uploads/mango-png/mango-diy-skin-care-hacks-for-mangoes-mangoes-for-your-skin-2.png',
    'https://media.istockphoto.com/id/1194662606/photo/orange-isolated-on-white-background-clipping-path-full-depth-of-field.jpg?b=1&s=612x612&w=0&k=20&c=kY_2x9lVS8jATtj0ubH9N0Zv5Htte4fwZ9JJHWCaqLE=',
    'https://thumbs.dreamstime.com/b/three-grapes-leaves-7467011.jpg',
    'https://purepng.com/public/uploads/large/purepng.com-bananafruitsyellowfruit-981524754330lspp8.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzRqoqRvpPR8e8tM_rNbzQBU2kr34qwT_JlDcfuleD&s',
    'https://media.istockphoto.com/id/1488579837/photo/peach-fruit-isolated-on-white-background-three-peach-fruits-whole-and-cut-pieces.webp?b=1&s=170667a&w=0&k=20&c=4V_YvjRV6xuvZtBZslChto9heLKwE8z74Ar3nPpFeC0=',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTFXh_diEnf0z3iBSNJH1mLW0Jviuy28ymR0-LbGGcKQ&s',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child){
                    return Text(value.getCounter().toString(), style: TextStyle(color: Colors.white),);
                  },
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: productName.length,
              itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                           Image(
                             height: 100,
                               width: 100,
                               image: NetworkImage(productImages[index].toString())),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: Text(productName[index].toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),),
                                  ),
                                  SizedBox(height:5 ,),
                                  Text(productUnit[index].toString()+' '+r'$'+productPrice[index].toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black26),),
                                  SizedBox(height:5 ,),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: (){
                                          dbHelper!.insert(Cart(id: index,
                                              productId: index.toString(),
                                              productName: productName[index].toString(),
                                              initialPrice: productPrice[index],
                                              productPrice: productPrice[index],
                                              quantity: 1,
                                              unitTag: productUnit[index].toString(),
                                              image: productImages[index].toString())).then((value){
                                             print('product is added to cart');
                                             cart.addTotalPrice(double .parse(productPrice[index].toString()));
                                             cart.addCounter();
                                             
                                          }).onError((error, stackTrace){
                                            print(error.toString());
                                          });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child: Text('Add a Cart', style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),

        ],
      ),
    );
  }
}


