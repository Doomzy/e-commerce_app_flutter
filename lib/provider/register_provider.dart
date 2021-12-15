import 'package:ecommerce_flutter/models/models.dart';
import 'package:ecommerce_flutter/screens/login.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:ecommerce_flutter/shared/services/dio/dio.dart';
import 'package:ecommerce_flutter/shared/services/endpoints.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  var registerError = '';

  bool obscurePassword = true;
  IconData passwordVisiblity = Icons.visibility_outlined;

  var registerName = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPhone = TextEditingController();
  var registerPass = TextEditingController();

  bool gettingData = false;
  LoginResponse? loginResponse;

  void togglePassword() {
    obscurePassword = !obscurePassword;
    obscurePassword
        ? passwordVisiblity = Icons.visibility_outlined
        : passwordVisiblity = Icons.visibility_off_outlined;
    notifyListeners();
  }

  void register(context) {
    gettingData = true;
    notifyListeners();
    DioHelper.postData(url: registerEP, data: {
      "name": registerName.text,
      "phone": registerPhone.text,
      "email": registerEmail.text,
      "password": registerPass.text,
    }).then((value) {
      gettingData = false;
      if (value.data['status'] == false) {
        registerError = value.data['message'];
        notifyListeners();
      } else {
        registerError = '';
        navigateAndRemoveUntil(context, LoginScreen());
      }
    });
  }
}
