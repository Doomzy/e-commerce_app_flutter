import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map myFavorites =
        Provider.of<StoreProvider>(context, listen: true).inFavorites;
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<StoreProvider>(
        builder: (context, sp, child) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                height: 300,
                child: Image(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  image: NetworkImage(sp.productImg),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15, end: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(bottom: 15),
                      height: 75,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => InkWell(
                          onTap: () => sp.changeProductImg(
                            sp.productDetails!.images![i],
                          ),
                          child: Image(
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                            image: NetworkImage(
                              sp.productDetails!.images![i],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, i) => SizedBox(width: 15.0),
                        itemCount: sp.productDetails!.images!.length,
                      ),
                    ),
                    Text(
                      sp.productDetails!.name,
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          '${sp.productDetails!.price.round()} L.E',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5.0),
                        sp.productDetails!.price.round() !=
                                sp.productDetails!.oldPrice.round()
                            ? Text(
                                '${sp.productDetails!.oldPrice.round()} L.E',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red),
                              )
                            : SizedBox(),
                        Spacer(),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: myFavorites[sp.productDetails!.id]
                              ? Colors.red
                              : Colors.grey,
                          child: IconButton(
                            padding: EdgeInsetsDirectional.all(0),
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              size: 25,
                              color: Colors.white60,
                            ),
                            onPressed: () => Provider.of<StoreProvider>(context,
                                    listen: false)
                                .addOrDeleteFavorite(sp.productDetails!.id),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Description :',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${sp.productDetails!.description}',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
