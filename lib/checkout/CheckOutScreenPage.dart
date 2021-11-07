import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homebazaar/cart/SavedProducts.dart';
import 'package:homebazaar/providers/Providers.dart';

class CheckOutScreenPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final savedProducts = watch(cartProductsNotifier).savedProductsInCart;
    return Scaffold(
      appBar: AppBar(title: Text("Product Checkout")),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex:5,
                child:Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue,Colors.orangeAccent],
                    ),
                  ),
                  child: Column(
                      children: [
                        SizedBox(height: 110.0,),
                        CircleAvatar(radius: (52),
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(50),
                              child: Image.asset("assets/homebazaar.jpg"),
                            )
                        ),
                        SizedBox(height: 10.0,),
                        Text('Home Bazaar',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                            )),
                        SizedBox(height: 10.0,),
                      ]
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Card(
                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child:Column(
                                children: [
                                  Text('Order id',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text("88",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),

                          Container(
                            child: Column(
                                children: [
                                  Text('Order Date',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('November 7th',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ]),
                          ),

                          Container(
                              child:Column(
                                children: [
                                  Text('Delivery By',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('November 11',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                ),
              ),
              Expanded(
                flex:5,
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                      child:Card(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                          child: Consumer(
                              builder: (builder, watch , child){
                                return Container(
                                  child :_buildCheckOutList(savedProducts),
                                );
                              }
                          ),
                      )
                  ),
                ),
              ),
            ],
          ),

        ],

      ),
    );
  }

  ListView _buildCheckOutList(List<SavedProducts> productList){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: productList.length,
        itemBuilder: (context, index){
            SavedProducts savedProducts = productList[index];
            return ListTile(
              title: Text(savedProducts.product.title!),
            );
        }
    );
  }

  Widget getRow(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.home,
          color: Colors.blueAccent[400],
          size: 35,
        ),
        SizedBox(width: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Guild",
              style: TextStyle(
                fontSize: 15.0,
              ),),
            Text("FairyTail, Magnolia",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),)
          ],
        )

      ],
    );
  }
}

