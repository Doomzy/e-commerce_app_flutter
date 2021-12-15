import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<StoreProvider>(
        builder: (context, sp, child) => Padding(
          padding: EdgeInsetsDirectional.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultFormField(
                  label: 'Search',
                  suffix: Icons.search,
                  isObscure: false,
                  controller: sp.searchController,
                  validatorMsg: 'Please enter a valid keyword',
                  onChange: (kw) => sp.searchKeyword(kw),
                ),
                SizedBox(height: 40),
                sp.dataResponse != null
                    ? GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1 / 1.5,
                        children: sp.dataResponse!.data
                            .map(
                              (p) => storeItem(
                                context,
                                product: p,
                                onTap: () =>
                                    sp.getProductDetails(p.id, context),
                              ),
                            )
                            .toList(),
                      )
                    : Text('No search results'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
