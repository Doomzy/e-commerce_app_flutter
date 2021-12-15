import 'package:ecommerce_flutter/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, pp, child) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.all(25.0),
            child: Column(
              children: [
                Container(
                  child: pp.isUpdating ? LinearProgressIndicator() : SizedBox(),
                ),
                pp.profileUpdatePages[pp.profileTab]
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) => pp.changeTab(i),
          currentIndex: pp.profileTab,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'General'),
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Password'),
          ],
        ),
      ),
    );
  }
}
