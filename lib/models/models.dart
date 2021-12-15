class LoginResponse {
  bool? status;
  String? message;
  UserData? data;

  LoginResponse.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data =
        jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    points = jsonData['points'];
    credit = jsonData['credit'];
    token = jsonData['token'];
  }
}

class HomeResponse {
  bool? status;
  List<BannerData> banners = [];
  List<ProductData> products = [];

  HomeResponse.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    jsonData['data']['banners'].forEach((banner) {
      banners.add(BannerData.fromJson(banner));
    });
    jsonData['data']['products'].forEach((product) {
      products.add(ProductData.fromJson(product));
    });
  }
}

class BannerData {
  int? id;
  String img = "";

  BannerData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    img = jsonData['image'];
  }
}

class ProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String img = '';
  String name = '';
  dynamic description;
  dynamic images;
  bool? inFav;
  bool? inCart;

  ProductData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'] ?? 0;
    discount = jsonData['discount'] ?? 0;
    img = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'] ?? '';
    images = jsonData['images'] ?? [];
    inFav = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}

class CategoriesResponse {
  bool status = false;
  List<CategoriesData> categoryData = [];

  CategoriesResponse.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    jsonData['data']['data'].forEach((cat) {
      categoryData.add(CategoriesData.fromJson(cat));
    });
  }
}

class CategoriesData {
  int? id;
  String name = '';
  String img = '';

  CategoriesData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    img = jsonData['image'];
  }
}

class FavoritesResponse {
  bool? status;
  int? total;
  List<ProductData> favData = [];

  FavoritesResponse.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    total = jsonData['data']['total'];
    jsonData['data']['data'].forEach((fav) {
      favData.add(ProductData.fromJson(fav['product']));
    });
  }
}

class SpecificDataResponse {
  bool? status;
  int? total;
  List<ProductData> data = [];

  SpecificDataResponse.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    total = jsonData['data']['total'];
    jsonData['data']['data'].forEach((pr) {
      data.add(ProductData.fromJson(pr));
    });
  }
}

class ProfileData {
  int? id;
  String name = '';
  String email = '';
  String phone = '';
  String img = '';
  String token = '';

  ProfileData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['data']['id'];
    name = jsonData['data']['name'];
    email = jsonData['data']['email'];
    phone = jsonData['data']['phone'];
    img = jsonData['data']['image'];
    token = jsonData['data']['token'];
  }
}
