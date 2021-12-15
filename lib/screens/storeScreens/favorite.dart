import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, sp, child) => sp.favoritesResponse != null
          ? sp.favoritesResponse!.total! > 0
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) => favoriteItem(
                    context,
                    product: sp.favoritesResponse!.favData[i],
                    onTap: () => sp.getProductDetails(
                      sp.favoritesResponse!.favData[i].id,
                      context,
                    ),
                  ),
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: sp.favoritesResponse!.favData.length,
                )
              : Center(
                  child: Text('No Favorites'),
                )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
