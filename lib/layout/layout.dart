import 'package:ecommerce_flutter/provider/login_provider.dart';
import 'package:ecommerce_flutter/provider/profile_provider.dart';
import 'package:ecommerce_flutter/provider/register_provider.dart';
import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/shared/services/shared_var.dart';
import 'package:ecommerce_flutter/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  Widget startingWidget;

  MyApp({
    required this.startingWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider()..getUserData(token),
        ),
        ChangeNotifierProvider<StoreProvider>(
          create: (context) => StoreProvider()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorite(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        home: startingWidget,
      ),
    );
  }
}
