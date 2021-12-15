import 'package:ecommerce_flutter/screens/login.dart';
import 'package:ecommerce_flutter/screens/onboarding.dart';
import 'package:ecommerce_flutter/screens/store.dart';
import 'package:ecommerce_flutter/shared/services/dio/dio.dart';
import 'package:flutter/material.dart';
import 'layout/layout.dart';
import 'shared/services/shared_prefrences/shared_prefrences.dart';
import 'shared/services/shared_var.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  await CacheHandler.init();
  Widget myWidget;
  dynamic onboardingDone = CacheHandler.getData(key: 'onboardingDone');

  if (onboardingDone != null) {
    if (token != null) {
      myWidget = StoreScreen();
    } else {
      myWidget = LoginScreen();
    }
  } else {
    myWidget = OnboardingScreen();
  }

  runApp(MyApp(startingWidget: myWidget));
}
