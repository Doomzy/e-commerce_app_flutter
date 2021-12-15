import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, sp, child) => sp.categoriesResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, i) => categoriesItem(
                catData: sp.categoriesResponse!.categoryData[i],
                onTap: () => sp.getCategoryDetails(
                  sp.categoriesResponse!.categoryData[i],
                  context,
                ),
              ),
              separatorBuilder: (context, i) => Divider(),
              itemCount: sp.categoriesResponse!.categoryData.length,
            ),
    );
  }
}
