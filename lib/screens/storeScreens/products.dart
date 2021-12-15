import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, sp, child) => sp.homeResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  bannersCarousel(banners: sp.homeResponse!.banners),
                  sectionTitle(title: 'Categories'),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => categoriesLvItem(
                        category: sp.categoriesResponse!.categoryData[i],
                        onTap: () => sp.getCategoryDetails(
                          sp.categoriesResponse!.categoryData[i],
                          context,
                        ),
                      ),
                      separatorBuilder: (context, i) => SizedBox(width: 15.0),
                      itemCount: sp.categoriesResponse!.categoryData.length,
                    ),
                  ),
                  sectionTitle(title: 'New Products'),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.3,
                    children: sp.homeResponse!.products
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
    );
  }
}

Widget bannersCarousel({required List banners}) => CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, i, j) => Image(
        height: double.infinity,
        fit: BoxFit.cover,
        image: NetworkImage(banners[i].img),
      ),
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1.0,
        autoPlay: true,
      ),
    );

Widget sectionTitle({required String title}) => Container(
      padding: EdgeInsetsDirectional.all(20.0),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
