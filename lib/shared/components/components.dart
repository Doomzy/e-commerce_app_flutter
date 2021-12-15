import 'package:ecommerce_flutter/models/models.dart';
import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void navigateAndRemoveUntil(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Widget defaultFormField({
  required String label,
  prefix,
  required bool isObscure,
  required controller,
  required String validatorMsg,
  suffix,
  VoidCallback? suffixOnPressed,
  void Function(String kw)? onChange,
}) =>
    TextFormField(
      obscureText: isObscure,
      controller: controller,
      onChanged: onChange,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorMsg;
        }
      },
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixOnPressed,
              )
            : null,
        contentPadding: EdgeInsetsDirectional.all(25.0),
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  required String label,
  required VoidCallback onPressed,
  bool? isDisabled,
}) =>
    MaterialButton(
      minWidth: double.infinity,
      padding: EdgeInsetsDirectional.all(20.0),
      color: Color.fromRGBO(212, 14, 20, 1),
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(fontSize: 20.0),
      ),
    );

Widget storeItem(context,
    {required ProductData product, required VoidCallback onTap}) {
  Map myFavorites =
      Provider.of<StoreProvider>(context, listen: true).inFavorites;
  return Container(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.contain,
                image: NetworkImage(product.img),
              ),
              product.discount!.round() > 0
                  ? Container(
                      child:
                          Text('Sale!', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      padding: EdgeInsetsDirectional.all(5.0),
                    )
                  : SizedBox(),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.all(10.0),
            child: Column(
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.2),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '${product.price.round()} L.E',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.0),
                    product.discount!.round() > 0
                        ? Text(
                            '${product.oldPrice.round()} L.E',
                            style: TextStyle(
                                fontSize: 10.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red),
                          )
                        : SizedBox(),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          myFavorites[product.id] ? Colors.red : Colors.grey,
                      child: IconButton(
                        padding: EdgeInsetsDirectional.all(0),
                        icon: Icon(
                          Icons.favorite_outline_rounded,
                          size: 14,
                          color: Colors.white60,
                        ),
                        onPressed: () =>
                            Provider.of<StoreProvider>(context, listen: false)
                                .addOrDeleteFavorite(product.id),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget categoriesLvItem({
  required CategoriesData category,
  required VoidCallback onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Image(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            image: NetworkImage(category.img),
          ),
          Container(
            width: 100,
            height: 100,
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

Widget favoriteItem(context,
    {required ProductData product, required VoidCallback onTap}) {
  Map myFavorites =
      Provider.of<StoreProvider>(context, listen: true).inFavorites;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsetsDirectional.all(20),
      height: 150,
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                width: 120,
                height: 120,
                image: NetworkImage(product.img),
              ),
              product.discount!.round() > 0
                  ? Container(
                      child:
                          Text('Sale!', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      padding: EdgeInsetsDirectional.all(5.0),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.2),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${product.price.round()} L.E',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                    product.discount!.round() > 0
                        ? Text(
                            '${product.oldPrice.round()} L.E',
                            style: TextStyle(
                                fontSize: 10.0,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red),
                          )
                        : SizedBox(),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          myFavorites[product.id] ? Colors.red : Colors.grey,
                      child: IconButton(
                        padding: EdgeInsetsDirectional.all(0),
                        icon: Icon(
                          Icons.favorite_outline_rounded,
                          size: 14,
                          color: Colors.white60,
                        ),
                        onPressed: () =>
                            Provider.of<StoreProvider>(context, listen: false)
                                .addOrDeleteFavorite(product.id),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget profileFields({
  required String fieldLabel,
  required String fieldData,
}) =>
    Row(
      children: [
        Text(
          fieldLabel,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 15.0),
        Text(
          fieldData,
          style: TextStyle(
            fontSize: 15.0,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

Widget categoriesItem({
  required CategoriesData catData,
  required VoidCallback onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsetsDirectional.all(15.0),
          child: Row(
            children: [
              Image(
                width: 75,
                height: 75,
                image: NetworkImage(catData.img),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                catData.name,
                style: TextStyle(fontSize: 25.0),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
