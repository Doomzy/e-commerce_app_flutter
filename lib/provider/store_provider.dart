import 'package:ecommerce_flutter/models/models.dart';
import 'package:ecommerce_flutter/screens/dataScreens/catergory_details.dart';
import 'package:ecommerce_flutter/screens/dataScreens/product_details.dart';
import 'package:ecommerce_flutter/screens/storeScreens/categories.dart';
import 'package:ecommerce_flutter/screens/storeScreens/favorite.dart';
import 'package:ecommerce_flutter/screens/storeScreens/products.dart';
import 'package:ecommerce_flutter/screens/storeScreens/profile.dart';
import 'package:ecommerce_flutter/shared/services/dio/dio.dart';
import 'package:ecommerce_flutter/shared/services/endpoints.dart';
import 'package:ecommerce_flutter/shared/services/shared_var.dart';
import 'package:flutter/material.dart';

class StoreProvider extends ChangeNotifier {
  int btmNavIndex = 0;
  List<Widget> storeTabs = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    ProfileScreen()
  ];
  List tabNames = ['Home', 'Categories', 'Favorites', 'Profile'];

  HomeResponse? homeResponse;
  CategoriesResponse? categoriesResponse;
  FavoritesResponse? favoritesResponse;
  SpecificDataResponse? dataResponse;

  Map<int?, bool?> inFavorites = {};

  String navTitle = 'Home';
  String categoryName = '';

  var searchController = TextEditingController();

  String productImg = 'images/ere.jpg';
  ProductData? productDetails;

  void changeTab(i) {
    btmNavIndex = i;
    navTitle = tabNames[i];
    notifyListeners();
  }

  void getHomeData() {
    DioHelper.getData(
      url: homeEP,
      token: token,
    ).then((value) {
      homeResponse = HomeResponse.fromJson(value.data);
      homeResponse!.products.forEach((element) {
        inFavorites.addAll({
          element.id: element.inFav,
        });
      });
      notifyListeners();
    });
  }

  void getCategoriesData() {
    DioHelper.getData(url: categoriesEP).then((value) {
      categoriesResponse = CategoriesResponse.fromJson(value.data);
      notifyListeners();
    });
  }

  void getCategoryDetails(catData, context) {
    DioHelper.getData(
      url: '$categoriesEP/${catData.id.toString()}',
    ).then((value) {
      categoryName = catData.name;
      dataResponse = SpecificDataResponse.fromJson(value.data);
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoryDetailsScreen()),
      );
    });
  }

  void getFavorite() {
    DioHelper.getData(
      url: favouritesEP,
      token: token,
    ).then((value) {
      favoritesResponse = FavoritesResponse.fromJson(value.data);
      notifyListeners();
    });
  }

  void addOrDeleteFavorite(itemId) {
    inFavorites[itemId] = !inFavorites[itemId]!;
    notifyListeners();

    DioHelper.postData(
      url: favouritesEP,
      data: {'product_id': itemId},
      token: token,
    ).then((value) {
      if (value.data['status'] == false) {
        inFavorites[itemId] = !inFavorites[itemId]!;
        notifyListeners();
      } else {
        getFavorite();
      }
    });
  }

  void searchKeyword(kw) {
    DioHelper.postData(url: searchEP, data: {"text": kw}).then((value) {
      dataResponse = SpecificDataResponse.fromJson(value.data);
      notifyListeners();
    });
  }

  void getProductDetails(id, context) {
    DioHelper.getData(
      url: '$productEP${id.toString()}',
    ).then((value) {
      productDetails = ProductData.fromJson(value.data['data']);
      productImg = productDetails!.img;
      notifyListeners();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
      );
    });
  }

  void changeProductImg(s) {
    productImg = s;
    notifyListeners();
  }
}
