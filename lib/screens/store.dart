import 'package:ecommerce_flutter/provider/store_provider.dart';
import 'package:ecommerce_flutter/screens/dataScreens/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, sp, child) => Scaffold(
        appBar: AppBar(
          title: Text(sp.navTitle),
          actions: [
            IconButton(
              onPressed: () {
                sp.dataResponse = null;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: sp.storeTabs[sp.btmNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => sp.changeTab(i),
          currentIndex: sp.btmNavIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
