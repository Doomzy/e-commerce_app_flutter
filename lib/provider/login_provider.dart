import 'package:ecommerce_flutter/models/models.dart';
import 'package:ecommerce_flutter/screens/store.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:ecommerce_flutter/shared/services/dio/dio.dart';
import 'package:ecommerce_flutter/shared/services/endpoints.dart';
import 'package:ecommerce_flutter/shared/services/shared_prefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  var loginError = '';

  bool obscurePassword = true;
  IconData passwordVisiblity = Icons.visibility_outlined;

  bool gettingData = false;
  LoginResponse? loginResponse;

  void togglePassword() {
    obscurePassword = !obscurePassword;
    obscurePassword
        ? passwordVisiblity = Icons.visibility_outlined
        : passwordVisiblity = Icons.visibility_off_outlined;
    notifyListeners();
  }

  void login({required email, required password, myContext}) {
    gettingData = true;
    notifyListeners();
    DioHelper.postData(
      url: loginEP,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginResponse = LoginResponse.fromJson(value.data);
      loginError = loginResponse!.message ?? '';
      gettingData = false;
      if (loginResponse!.data != null) {
        CacheHandler.saveData(key: 'token', value: loginResponse!.data!.token);
        navigateAndRemoveUntil(myContext, StoreScreen());
      }
      notifyListeners();
    });
  }
}
