import 'package:ecommerce_flutter/models/models.dart';
import 'package:ecommerce_flutter/screens/login.dart';
import 'package:ecommerce_flutter/screens/profileScreens/gen_info.dart';
import 'package:ecommerce_flutter/screens/profileScreens/password.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:ecommerce_flutter/shared/services/dio/dio.dart';
import 'package:ecommerce_flutter/shared/services/endpoints.dart';
import 'package:ecommerce_flutter/shared/services/shared_prefrences/shared_prefrences.dart';
import 'package:ecommerce_flutter/shared/services/shared_var.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileData? userData;
  bool isUpdating = false;

  var profileName = TextEditingController();
  var profileEmail = TextEditingController();
  var profilePhone = TextEditingController();
  String genError = '';

  var currPassword = TextEditingController();
  var newPasssword = TextEditingController();
  String passError = '';

  List<Widget> profileUpdatePages = [GenInfoScreen(), PasswordSreen()];
  int profileTab = 0;

  void changeTab(i) {
    profileTab = i;
    notifyListeners();
  }

  void getUserData(token) {
    DioHelper.getData(
      url: profileEP,
      token: token,
    ).then((value) {
      userData = ProfileData.fromJson(value.data);
      profileName.text = userData!.name.toString();
      profileEmail.text = userData!.email.toString();
      profilePhone.text = userData!.phone.toString();
      notifyListeners();
    });
  }

  void logoutUser(context) {
    CacheHandler.deleteData(key: 'token');
    navigateAndRemoveUntil(context, LoginScreen());
  }

  void updateUser(context) {
    isUpdating = true;
    notifyListeners();
    DioHelper.putData(
      url: updateProfileEP,
      data: {
        "name": profileName.text,
        "email": profileEmail.text,
        "phone": profilePhone.text,
      },
      token: token,
    ).then((value) {
      isUpdating = false;
      if (value.data['status'] == false) {
        genError = value.data['message'];
        notifyListeners();
      } else {
        userData = ProfileData.fromJson(value.data);
        genError = '';
        Navigator.pop(context);
        notifyListeners();
      }
    });
  }

  void changePassword(context) {
    isUpdating = true;
    DioHelper.postData(
      url: passChangeEP,
      data: {
        "current_password": currPassword.text,
        "new_password": newPasssword.text
      },
      token: token,
    ).then((value) {
      isUpdating = false;
      if (value.data['status'] == false) {
        passError = 'Please enter your correct password';
        notifyListeners();
      } else {
        passError = '';
        Navigator.pop(context);
      }
    });
  }
}
