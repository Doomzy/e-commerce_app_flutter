import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<StoreProvider>(
        builder: (context, sp, child) => sp.dataResponse!.data.length == 0
            ? Text("No products")
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Categories/ ${sp.categoryName}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 40),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.3,
                      children: sp.dataResponse!.data
                          .map(
                            (p) => storeItem(
                              context,
                              product: p,
                              onTap: () => sp.getProductDetails(p.id, context),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
